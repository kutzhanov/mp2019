#! /bin/bash

sudo yum install httpd
sudo yum install php
sudo yum install php-mysql
cd /var/www/html/
sudo touch index.php
sudo echo "<?php
$servername = "mp2019-db";
$username = "admin";
$password = "Rt80#j3I-Cd";

// Create connection
$conn = mysqli_connect($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
?>" >> index.php

sudo service httpd start (start http)
sudo chkconfig httpd on (add to autostart)