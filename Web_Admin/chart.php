<?php
require_once 'appdb.php'; // Make sure to include your database connection file


// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query to get signup data grouped by date
$sql = "SELECT DATE(signup_datetime) AS signup_date, COUNT(*) AS user_count 
        FROM users 
        GROUP BY signup_date 
        ORDER BY signup_date";

$result = $conn->query($sql);

// Prepare data for JSON response
$data = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// Return data as JSON
echo json_encode($data);

// Close connection
$conn->close();
?>
