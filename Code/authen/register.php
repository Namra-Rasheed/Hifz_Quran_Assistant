<?php
include 'db.php';

// Get form data
$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];
$confirmPassword = $_POST['confirm_password'];
$contactNumber = $_POST['contact_number'];

// Validate form data
if (empty($username) || empty($email) || empty($password) || empty($confirmPassword) || empty($contactNumber)) {
    echo json_encode(array("status" => 0, "msg" => "All fields are required"));
    exit();
}

// Check if password and confirm password match
if ($password !== $confirmPassword) {
    echo json_encode(array("status" => 0, "msg" => "Passwords do not match"));
    exit();
}

// Check if username or email already exists
$sql = "SELECT * FROM users WHERE username = '$username' OR email = '$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo json_encode(array("status" => 0, "msg" => "Username or email already exists"));
    exit();
}

// Hash the password
$hashedPassword = password_hash($password, PASSWORD_BCRYPT);

// Insert user into database
$sql = "INSERT INTO users (username, email, password, contact_number) VALUES ('$username', '$email', '$hashedPassword', '$contactNumber')";
if ($conn->query($sql) === TRUE) {
    echo json_encode(array("status" => 1, "msg" => "User registered successfully!"));
} else {
    echo json_encode(array("status" => 0, "msg" => "Error: " . $sql . "<br>" . $conn->error));
}

$conn->close();
?>
