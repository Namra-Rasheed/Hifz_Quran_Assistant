<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Question</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #afc69e;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            color: #ffffff;
            text-align: center;
        }

        

        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            padding: 25px;
            max-width: 450px;
            width: 100%;
            color: #333333;
            text-align: left;
        }

        h1 {
            font-size: 24px;
            color: #244809;
            margin-bottom: 15px;
            text-align: center;
        }

        label {
            font-size: 16px;
            color: #4f9727;
            display: block;
            margin-bottom: 8px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #cccccc;
            border-radius: 8px;
            font-size: 14px;
            background: #f9f9f9;
        }

        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #43cea2;
            outline: none;
            background: #e3f2fd;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #244809;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #afc69e;
        }

        .form-group {
            margin-bottom: 20px;
        }

        @media (max-width: 500px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 20px;
            }

            input[type="text"], input[type="number"] {
                font-size: 14px;
            }

            button {
                font-size: 15px;
            }
        }
    </style>
</head>
<body>
    
    <div class="container">
        <h1>Insert a New Question</h1>
        <form action="insert_question.php" method="post">
            <div class="form-group">
                <label for="question_text">Question Text:</label>
                <input type="text" id="question_text" name="question_text" required>
            </div>

            <div class="form-group">
                <label for="option1">Option 1:</label>
                <input type="text" id="option1" name="option1" required>
            </div>

            <div class="form-group">
                <label for="option2">Option 2:</label>
                <input type="text" id="option2" name="option2" required>
            </div>

            <div class="form-group">
                <label for="option3">Option 3:</label>
                <input type="text" id="option3" name="option3" required>
            </div>

            <div class="form-group">
                <label for="option4">Option 4:</label>
                <input type="text" id="option4" name="option4" required>
            </div>

            <div class="form-group">
                <label for="correct_option">Correct Option (1-4):</label>
                <input type="number" id="correct_option" name="correct_option" min="1" max="4" required>
            </div>

            <button type="submit">Insert Question</button>
        </form>
    </div>
</body>
</html>
