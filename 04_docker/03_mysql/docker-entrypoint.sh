#!/bin/bash -ex

set -eo pipefail

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'MYSQL_USER'
chown ${MYSQL_USER}:${MYSQL_USER} /usr/sbin/"$@"

_get_config() {
	local conf="$1"; shift
	"$@" --verbose --help --log-bin-index="$(mktemp -u)" 2>/dev/null \
		| awk '$1 == "'"$conf"'" && /^[^ \t]/ { sub(/^[^ \t]+[ \t]+/, ""); print; exit }'
	# match "datadir      /some/path with/spaces in/it here" but not "--xyz=abc\n     datadir (xyz)"
}

DATADIR="$(_get_config 'datadir' "$@")"
SOCKET="$(_get_config 'socket' "$@")"

echo '[Entrypoint] Initializing database'
"$@" --initialize-insecure

mkdir -p "$DATADIR"

"$@" --skip-networking --socket="${SOCKET}" --user=root &
pid="$!"

# Define the client command used throughout the script
mysql=( mysql --protocol=socket -uroot -hlocalhost --socket="${SOCKET}" )

for i in {30..0}; do
  if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
    break
  fi
  echo 'MySQL init process in progress...'
  sleep 1
done
if [ "$i" = 0 ]; then
  echo >&2 'MySQL init process failed.'
  exit 1
fi

file_env 'MYSQL_ROOT_PASSWORD'
"${mysql[@]}" <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}' ;
  GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;
  DROP DATABASE IF EXISTS test ;
  FLUSH PRIVILEGES ;
EOSQL

if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
  mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
fi

file_env 'MYSQL_DATABASE'
if [ "$MYSQL_DATABASE" ]; then
  echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
  mysql+=( "$MYSQL_DATABASE" )
fi

file_env 'MYSQL_PASSWORD'
if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
  echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$MYSQL_PASSWORD' ;" | "${mysql[@]}"

  if [ "$MYSQL_DATABASE" ]; then
    echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
  fi

  echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
fi

chown -R ${MYSQL_USER}:${MYSQL_USER} "$DATADIR"

if ! kill -s TERM "$pid" || ! wait "$pid"; then
  echo >&2 'MySQL init process failed.'
  exit 1
fi

echo
echo 'MySQL init process done. Ready for start up.'
echo

echo '[Entrypoint] Running server'
$@ --user=${MYSQL_USER} --character-set-server=utf8 --collation-server=utf8_unicode_ci
