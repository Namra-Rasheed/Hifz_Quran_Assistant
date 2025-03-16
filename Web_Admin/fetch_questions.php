<?php
include 'db.php';

$sql = "SELECT * FROM questions";
$result = $conn->query($sql);

$questions = array();
while ($row = $result->fetch_assoc()) {
    $questions[] = $row;
}

echo json_encode($questions);
?>
