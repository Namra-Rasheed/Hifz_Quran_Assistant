<?php
session_start();  // Start the session

// Debugging: Check if session is set
var_dump($_SESSION);  // Print session data for debugging

// Check if the user is logged in
if (isset($_SESSION['username'])) {
    $username = $_SESSION['username'];  // Get username from session
} else {
    $username = "Guest";  // If not logged in, show "Guest"
}
?>


<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hifz Quran Admin Panel</title>
    <link href="https://cdn.lineicons.com/4.0/lineicons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: black;
        }

        .row-container {
    display: flex; /* Row-wise arrangement */
    justify-content: space-between; /* Space between elements */
    align-items: stretch; /* Align items vertically in center */
    gap: 20px; /* Space between cards */
}    
.card, 
.calendar-container, 
.chart-container {
    flex: 1; /* Equal space for all elements */
    max-width: 33%; /* Adjust width so they fit in one row */
    margin: 10px;
   

}

.card {
    text-align: center;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    border-radius: 10px;
    padding: 15px;
}

.calendar-container {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    
     background-color: #fff;
    border-radius: 10px;
}

.chart-container {
    text-align: center;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    border-radius: 10px;
    padding: 15px;
}
       

        /* Clock Card */
        

        /* Analog Clock */
        #analog-clock {
            width: 150px;
            height: 150px;
            margin: 0 auto;
            position: relative;
            background-color: #244809;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Clock Face */
        #clock-face {
            width: 100%;
            height: 100%;
            position: relative;
        }

        /* Hands */
        #hour-hand,
        #minute-hand,
        #second-hand {
            position: absolute;
            background-color: white;
            transform-origin: bottom;
            transform: translateX(-50%);
        }

        #hour-hand {
            width: 4px;
            height: 40px;
            top: 35%;
            left: 50%;
            background-color: #fff;
        }

        #minute-hand {
            width: 3px;
            height: 55px;
            top: 20%;
            left: 50%;
            background-color: #f8f9fa;
        }

        #second-hand {
            width: 2px;
            height: 60px;
            top: 15%;
            left: 50%;
            background-color: #ffc107;
        }

         /* Calendar Styles */
        

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .calendar-header button {
            background-color: transparent;
            border: none;
            font-size: 20px;
            cursor: pointer;
        }

        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-gap: 5px;
            margin-bottom: 10px;
        }

        .calendar-day {
            text-align: center;
            font-weight: bold;
        }

        .calendar-days-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-gap: 4px;
        }

        .calendar-day-cell {
            text-align: center;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;

        }

        .calendar-day-cell:hover {
            background-color:lightgreen;
        }

        .current-day {
            background-color: lightgreen;
        }
        
 
   


@media (max-width: 768px) {
    .row-container {
        flex-direction: column; /* Switch to column layout for smaller screens */
    }

    .card, 
    .calendar-container, 
    .chart-container {
        max-width: 100%; /* Full width for smaller screens */
    }
}
 
 /* New Button Row */
        .button-row {
            display: flex;
            justify-content: space-between;
            gap: 50px;
            margin-top: 50px;
            height: 60px;


        }

        .button-row .btn {
            flex: 1;
            text-align: center;
        }
        .search-bar {
            margin-bottom: 5px;
            padding: 10px;
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 1rem;
        }

    </style>
</head>

<body>
    <div class="wrapper">
        <aside id="sidebar">
            <div class="d-flex">
                <button class="toggle-btn" type="button">
                    <i class="lni lni-grid-alt"></i>
                </button>
                <div class="sidebar-logo">
                    <a href="#">Admin Panel</a>
                </div>
            </div>
            <ul class="sidebar-nav">
                <li class="sidebar-item">
                    <a href="#" class="sidebar-link">
                        <i class="lni lni-user"></i>
                        <span>Profile</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="show_users.html" class="sidebar-link">
                        <i class="lni lni-user"></i>
                        <span>Users</span>
                    </a>
                </li>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="#" class="sidebar-link collapsed has-dropdown" data-bs-toggle="collapse"
                        data-bs-target="#auth" aria-expanded="false" aria-controls="auth">
                        <i class="lni lni-protection"></i>
                        <span>Authentication</span>
                    </a>
                    <ul id="auth" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item">
                            <a href="login.html" class="sidebar-link">Login</a>
                        </li>
                        <li class="sidebar-item">
                            <a href="signup.html" class="sidebar-link">Register</a>
                        </li>
                    </ul>
                </li>
                <li class="sidebar-item">
                    <a href="#" class="sidebar-link collapsed has-dropdown" data-bs-toggle="collapse"
                        data-bs-target="#multi" aria-expanded="false" aria-controls="multi">
                        <i class="lni lni-layout"></i>
                        <span>Quran PAk</span>
                    </a>
                    <ul id="multi" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item">
                            <a href="#" class="sidebar-link collapsed" data-bs-toggle="collapse"
                                data-bs-target="#multi-two" aria-expanded="false" aria-controls="multi-two">
                                Content
                            </a>
                            <ul id="multi-two" class="sidebar-dropdown list-unstyled collapse">
                                <li class="sidebar-item">
                                    <a href="insert_question_form.php" class="sidebar-link">Quiz Exercise</a>
                                </li>
                                
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="sidebar-item">
                    <a href="appshowuser.html" class="sidebar-link">
                        <i class="lni lni-popup"></i>
                        <span>Application Users</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="#" class="sidebar-link">
                        <i class="lni lni-cog"></i>
                        <span>Setting</span>
                    </a>
                </li>
            </ul>
            <div class="sidebar-footer">
                <a href="logout.php" class="sidebar-link">
                    <i class="lni lni-exit"></i>
                    <span>logout</span>
                </a>
            </div>
        </aside>
        <div class="main">
            
            <main class="content px-3 py-4">
                <div class="container-fluid">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
    <h3 class="fw-bold fs-4 mb-3">Welcome To Hifz Quran Assistant</h3>
    <div style="display: flex; align-items: center;">
        <ul><img src="account.png" class="avatar img-fluid" alt="User Avatar" style="margin-right: 10px;">
        <p><?php echo $username; ?></p></ul>
    </div>
</div>

                    
                </div>
                
                <div class="container mt-5">
                    <div class="row-container">
        <!-- Clock Card -->
        <div class="card">
            <div class="card-header bg-success text-white">
                <h4 id="current-date"></h4>
                <p id="current-time" class="mb-0"></p>
            </div>
            <div class="card-body">
                <div id="analog-clock">
                    <div id="clock-face">
                        <div id="hour-hand"></div>
                        <div id="minute-hand"></div>
                        <div id="second-hand"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Calendar Card -->
                    <div class="calendar-container ">
                        <div class="calendar-header">
                            <button id="prev" onclick="changeMonth(-1)">&#60;</button>
                            <span id="month-year"></span>
                            <button id="next" onclick="changeMonth(1)">&#62;</button>
                        </div>
                        <div class="calendar-days">
                            <div class="calendar-day">Sun</div>
                            <div class="calendar-day">Mon</div>
                            <div class="calendar-day">Tue</div>
                            <div class="calendar-day">Wed</div>
                            <div class="calendar-day">Thu</div>
                            <div class="calendar-day">Fri</div>
                            <div class="calendar-day">Sat</div>
                        </div>
                        <div id="calendar-days-grid" class="calendar-days-grid"></div>
                    </div>
                     
                     <div class="chart-container">
                    <canvas id="signupChart"width="2" height="2"></canvas>
            
        </div>
     
     

</div>
<h2>User Details</h2>
            <input type="text" id="searchInput" class="search-bar" placeholder="Search by Name" onkeyup="searchUser()">
<div id="result"></div>
<!-- New Button Row -->
                    <div class="button-row">
                        <a href="appshowuser.html" class="btn btn-success">Application User</a>
                        <a href="insert_question_form.php" class="btn btn-success">Add Quiz Questions</a>
                        <a href="fetchquestion.html" class="btn btn-success"> View Quiz Questions</a>
                        
                       
                       <a href="#" class="btn btn-success"> Total Users
            <p id="total_users">0</p></a>

                    </div>

</div>   
    
         
       

    
</main>
<script>
function searchUser() {
    let name = document.getElementById("searchInput").value;

    if (name.length == 0) {
        document.getElementById("result").innerHTML = "";
        return;
    }

    let xhr = new XMLHttpRequest();
    xhr.open("GET", "searchuser.php?q=" + name, true); // Changed query to 'q'
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("result").innerHTML = xhr.responseText;
        }
    };
    xhr.send();
}
</script>
 
<script>
        // Function to fetch total users from backend
        function fetchTotalUsers() {
            fetch('totaluser.php')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('total_users').innerText = data.total_users;
                })
                .catch(error => {
                    console.error('Error fetching total users:', error);
                });
        }

        // Call function to fetch total users on page load
        window.onload = fetchTotalUsers;
    </script>

<script>
        // Update the Date and Time
        function updateDateTime() {
            const now = new Date();
            const options = { weekday: "long", year: "numeric", month: "long", day: "numeric" };

            // Update date and time in the card header
            document.getElementById("current-date").textContent = now.toLocaleDateString("en-US", options);
            document.getElementById("current-time").textContent = now.toLocaleTimeString("en-US");
        }

        // Update the Analog Clock
        function updateAnalogClock() {
            const now = new Date();
            const hours = now.getHours() % 12;
            const minutes = now.getMinutes();
            const seconds = now.getSeconds();

            // Rotate the hands
            document.getElementById("hour-hand").style.transform = `translateX(-50%) rotate(${hours * 30 + minutes / 2}deg)`;
            document.getElementById("minute-hand").style.transform = `translateX(-50%) rotate(${minutes * 6}deg)`;
            document.getElementById("second-hand").style.transform = `translateX(-50%) rotate(${seconds * 6}deg)`;
        }
      


      // Calendar functionality
        let currentDate = new Date();
        let currentMonth = currentDate.getMonth();
        let currentYear = currentDate.getFullYear();

        const monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ];

        function renderCalendar(month, year) {
            const monthYearElement = document.getElementById("month-year");
            monthYearElement.innerText = `${monthNames[month]} ${year}`;

            const calendarGrid = document.getElementById("calendar-days-grid");
            calendarGrid.innerHTML = "";

            const firstDay = new Date(year, month).getDay();
            const daysInMonth = new Date(year, month + 1, 0).getDate();

            for (let i = 0; i < firstDay; i++) {
                const emptyCell = document.createElement("div");
                emptyCell.classList.add("calendar-day-cell");
                calendarGrid.appendChild(emptyCell);
            }

            for (let day = 1; day <= daysInMonth; day++) {
                const dayCell = document.createElement("div");
                dayCell.classList.add("calendar-day-cell");
                dayCell.innerText = day;

                if (day === currentDate.getDate() && month === currentMonth && year === currentYear) {
                    dayCell.classList.add("current-day");
                }

                calendarGrid.appendChild(dayCell);
            }
        }

        function changeMonth(increment) {
            currentMonth += increment;

            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            } else if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }

            renderCalendar(currentMonth, currentYear);
        }
        

        // Refresh every second
        setInterval(() => {
            updateDateTime();
            updateAnalogClock();
        }, 1000);

        // Initialize the clock
        updateDateTime();
        updateAnalogClock();
        renderCalendar(currentMonth, currentYear);
       

    </script>

 <script>
         function fetchUsers() {
    fetch('app_fetchuser.php')
        .then(response => response.json())
        .then(users => {
            const userTable = document.getElementById('user-table');
            userTable.innerHTML = ''; // Clear the table

            users.forEach(user => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    <td>${user.contact_number}</td>
                    
                `;
                userTable.appendChild(row);
            });
        })
        .catch(error => console.error('Error fetching users:', error));
}

// Call fetchUsers on page load
fetchUsers();

     </script>

<script>
        // Fetch signup data from PHP script
        fetch('chart.php')
            .then(response => response.json())
            .then(data => {
                // Extract labels and data for the chart
                const labels = data.map(row => row.signup_date);
                const counts = data.map(row => row.user_count);

                // Create bar chart using Chart.js
                const ctx = document.getElementById('signupChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Number of Users',
                            data: counts,
                            backgroundColor: 'green',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Error fetching data:', error));
    </script>
            <footer class="footer">
                <div class="container-fluid">
                    <div class="row text-body-secondary">
                        <div class="col-6 text-start ">
                            <a class="text-body-secondary" href=" #">
                                <strong>Hifz Quran Assistant</strong>
                            </a>
                        </div>
                        <div class="col-6 text-end text-body-secondary d-none d-md-block">
                            <ul class="list-inline mb-0">
                                
                                <li class="list-inline-item">
                                    <a class="text-body-secondary" href="aboutaction.html">About Us</a>
                                </li>
                                <li class="list-inline-item">
                                    <a class="text-body-secondary" href="termaction.html">Terms & Conditions</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
    <script src="script.js"></script>
</body>

</html>