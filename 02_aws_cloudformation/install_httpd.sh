#! /bin/bash

sudo yum install httpd
sudo yum install php
sudo yum install php-mysql
cd /var/www/html/
sudo touch index.php
sudo echo "<?php
$servername = "dr12kk87lze2n5g.cm2uokxn1kjg.us-east-1.rds.amazonaws.com";
$username = "admin";
$password = "Rt80j3ICd";

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