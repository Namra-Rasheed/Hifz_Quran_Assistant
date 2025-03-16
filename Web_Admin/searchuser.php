<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");



// Database connection configuration
$servername = "localhost";
$username = "root"; // Change this if your database username is different
$password = ""; // Leave blank if there is no password (for localhost)
$dbname = "authen"; // Name of the database

if (isset($_GET['q'])) {
    $searchQuery = $_GET['q'];
    
   $conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

    // Search query
    $sql = "SELECT * FROM users WHERE username LIKE '%$searchQuery%'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            echo "User: " . $row['username'] . "<br>";
            echo "Email: " . $row['email'] . "<br>";
            echo "Contact Number: " . $row['contact_number'] . "<br>";
            

            echo "<hr>"; // Divider between users
        }
    } else {
        echo "No results found";
    }

    $conn->close();
}
?>

