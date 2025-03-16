<?php

// Database connection configuration
require_once  'appdb.php';

if (isset($_GET['email'])) {
    $email = $_GET['email'];

    // Debugging: Log received email to check if it's being passed correctly
    error_log("Received email: " . $email);

    // Prepare the delete query for TEXT field
    $query = "DELETE FROM users WHERE TRIM(email) = ?";

    if ($stmt = $conn->prepare($query)) {
        $stmt->bind_param("s", $email); // 's' means string for email
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
    echo json_encode(['status' => 'error', 'message' => 'User email not provided.']);
}
?>
