<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $responses = $data['responses'];
    $userId = $data['user_id'] ?? null; // If you need to track the user ID

    $score = 0; // Variable to track the total score

    foreach ($responses as $response) {
        $questionId = $response['question_id'];
        $selectedOption = $response['selected_option'];

        // Fetch the correct option from the database
        $sql = "SELECT correct_option FROM questions WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $questionId);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        // Evaluate if the answer is correct
        $isCorrect = ($row['correct_option'] == $selectedOption) ? 1 : 0;
        $score += $isCorrect; // Increment score if correct

        // Insert user answer into the database
        $insertSql = "INSERT INTO user_answers (user_id, question_id, selected_option, is_correct) 
                      VALUES (?, ?, ?, ?)";
        $insertStmt = $conn->prepare($insertSql);
        $insertStmt->bind_param("iiii", $userId, $questionId, $selectedOption, $isCorrect);
        $insertStmt->execute();
    }

    // Return the total score
    echo json_encode(["status" => "success", "score" => $score]);
}
?>
