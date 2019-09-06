<?php
echo gethostname();

$servername = "dr12kk87lze2n5g.cm2uokxn1kjg.us-east-1.rds.amazonaws.com";
$username = "admin";
$password = "Rt80j3ICd";
$hostname = gethostname();
// Create connection
$conn = new mysqli($servername, $username, $password);
// Check connection
if ($conn->connect_error) {
    die("$hostname connection failed: " . $conn->connect_error);
}
echo "$hostname successfully connected to $servername";
?>
