<?php
echo gethostname();

$servername = file_get_contents(getenv('MYSQL_SERVERNAME'));
$username = file_get_contents(getenv('MYSQL_USER'));
$password = file_get_contents(getenv('MYSQL_PASSWORD'));
$hostname = gethostname();
// Create connection
$conn = new mysqli($servername, $username, $password);
// Check connection
if ($conn->connect_error) {
    die("$hostname connection failed: " . $conn->connect_error);
}
echo "$hostname successfully connected to $servername";
?>
