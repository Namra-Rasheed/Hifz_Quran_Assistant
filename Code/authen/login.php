<?php
include 'db.php';

$username_or_email = $_POST['username_or_email'];
$password = $_POST['password'];

// Prepare and bind
$stmt = $conn->prepare("SELECT * FROM users WHERE username = ? OR email = ?");
$stmt->bind_param("ss", $username_or_email, $username_or_email);

$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        echo json_encode(array("status" => 1, "msg" => "Login successful"));
    } else {
        echo json_encode(array("status" => 0, "msg" => "Invalid password"));
    }
} else {
    echo json_encode(array("status" => 0, "msg" => "User not found"));
}

$stmt->close();
$conn->close();
?>



