<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Replace with your RDS database credentials
$servername = "csicg4.czptxhzjxjrt.us-east-1.rds.amazonaws.com";
$username = "group4";
$password = "Groupfour";
$dbname = "ice_shop";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


?>
