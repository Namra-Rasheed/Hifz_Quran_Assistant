<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $questionText = $_POST['question_text'];
    $option1 = $_POST['option1'];
    $option2 = $_POST['option2'];
    $option3 = $_POST['option3'];
    $option4 = $_POST['option4'];
    $correctOption = $_POST['correct_option'];

    $sql = "INSERT INTO questions (question_text, option1, option2, option3, option4, correct_option) 
            VALUES (?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssssi", $questionText, $option1, $option2, $option3, $option4, $correctOption);

    if ($stmt->execute()) {
        echo "Question inserted successfully!";
         // Redirect to a protected page or dashboard
             header("Location: fetchquestion.html");
    } else {
        echo "Error: " . $stmt->error;
    }
}
?>
