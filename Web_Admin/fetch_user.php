<?php
// Include the database connection file
require_once 'database.php';

// Query to fetch users
$sql = "SELECT id, name, email FROM users";
$result = $conn->query($sql);

$users = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
}

// Return data as JSON
header('Content-Type: application/json');
echo json_encode($users);

// Close the database connection
$conn->close();
?>
