<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Database connection configuration
$servername = "localhost";
$username = "root"; // Change this if your database username is different
$password = ""; // Leave blank if there is no password (for localhost)
$dbname = "authen"; // Name of the database

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query to get total users count
$sql = "SELECT COUNT(*) as total_users FROM users";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $total_users = $row['total_users'];
} else {
    $total_users = 0;
}

$conn->close();

// Return total users as JSON
echo json_encode(['total_users' => $total_users]);
?>
