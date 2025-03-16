<?php
header("Access-Control-Allow-Origin: *");

// Database connection configuration
$servername = "localhost";
$username = "root"; // Change this if your database username is different
$password = ""; // Leave blank if there is no password (for localhost)
$dbname = "quran_assistant"; // Name of the database

// Create a database connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}