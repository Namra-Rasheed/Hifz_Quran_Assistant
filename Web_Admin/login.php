<?php
session_start();  // Start the session to access session variables

// Include database connection file
include 'database.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Check if the user exists in the database
    $sql = "SELECT * FROM users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // User exists, verify the password
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            session_start();  // Start session to store user data
            $_SESSION['username'] = $user['name'];  // Store username in session

            echo "<script>alert('Login successful! Welcome, " . $user['name'] . "');</script>";
            header("Location: index.php");  // Redirect to index.php
            exit();
        } else {
            echo "<script>alert('Incorrect password. Please try again.');</script>";
        }
    } else {
        echo "<script>alert('No account found with that email. Please register first.');</script>";
    }
}
?>
