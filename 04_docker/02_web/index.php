<?php
$servername = getenv('MYSQL_SERVERNAME');
$username = file_get_contents(getenv('MYSQL_USER_FILE'));
$password = file_get_contents(getenv('MYSQL_PASSWORD_FILE'));
$hostname = gethostname();

echo  "Host name: " + $hostname + "\r\n"

// Create connection
$conn = new mysqli($servername, $username, $password);
// Check connection
if ($conn->connect_error) {
    die("$hostname connection failed: " . $conn->connect_error);
}
echo "Host $hostname successfully connected to $servername";
?>
