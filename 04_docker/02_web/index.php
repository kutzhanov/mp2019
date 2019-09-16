<?php
echo gethostname();

$servername = getenv('MYSQL_SERVERNAME');
$username = file_get_contents(getenv('MYSQL_USER_FILE'));
$password = file_get_contents(getenv('MYSQL_PASSWORD_FILE'));
$hostname = gethostname();
// Create connection
$conn = new mysqli($servername, $username, $password);
// Check connection
if ($conn->connect_error) {
    die("$hostname connection failed: " . $conn->connect_error);
}
echo "$hostname successfully connected to $servername";
?>
