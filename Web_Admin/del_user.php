<?php
// Include the database connection file
require_once 'database.php'; // Make sure to include your database connection file

if (isset($_GET['id'])) {
    $user_id = $_GET['id'];

    // Prepare the delete query
    $query = "DELETE FROM users WHERE id = ?";

    if ($stmt = $conn->prepare($query)) {
        $stmt->bind_param("i", $user_id); // 'i' means integer for user_id
        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'User deleted successfully.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error deleting user.']);
        }
        $stmt->close();
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Query preparation failed.']);
    }

    $conn->close();
} else {
    echo json_encode(['status' => 'error', 'message' => 'User ID not provided.']);
}
?>
