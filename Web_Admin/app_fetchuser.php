<?php
include 'appdb.php';

// Fetch all users from the database
$sql = "SELECT  username , email, contact_number FROM users";
$result = $conn->query($sql);

// Check if data exists
if ($result->num_rows > 0) {
    $users = array();

    // Loop through each row and store in an array
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }

    // Return data as JSON
    echo json_encode($users);
} else {
    // Return empty array if no users found
    echo json_encode([]);
}

$conn->close();
?>
