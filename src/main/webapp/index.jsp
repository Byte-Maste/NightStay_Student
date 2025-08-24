<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Nightstay - Login</title>
    <style>
        /* ... (Your existing CSS here) ... */
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --card-background: #ffffff;
            --border-color: #dfe4ea;
            --hover-color: #f6f8f9;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 500px;
            background: var(--card-background);
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-header {
            background-color: var(--primary-color);
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
        }

        .card-title {
            margin: 0 0 0.5rem;
            font-size: 2.5rem;
            font-weight: 600;
        }

        .card-subtitle {
            margin: 0;
            font-size: 1rem;
            font-weight: 300;
            opacity: 0.9;
        }

        .card-body {
            padding: 2.5rem 2rem;
        }

        .login-options {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .login-options input[type="radio"] {
            display: none;
        }

        .login-options label {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--secondary-color);
            cursor: pointer;
            padding-bottom: 5px;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
        }

        .login-options input[type="radio"]:checked + label {
            color: var(--primary-color);
            border-bottom: 3px solid var(--primary-color);
        }

        .form-container {
            animation: fadeIn 0.5s ease-in-out;
        }

        .form-title {
            font-size: 1.8rem;
            color: var(--secondary-color);
            margin-top: 0;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-grid {
            display: grid;
            gap: 1.25rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #555;
        }

        .form-group input, .form-select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-group input:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }

        .submit-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            background-color: var(--primary-color);
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #2980b9;
        }

        .full-width {
            width: 100%;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 576px) {
            .container {
                width: 100%;
                border-radius: 0;
                box-shadow: none;
            }
            .card-body {
                padding: 2rem 1.5rem;
            }
            .card-title {
                font-size: 2rem;
            }
            .form-title {
                font-size: 1.5rem;
            }
        }
    </style>
    <script>
        function toggleForm() {
            let studentForm = document.getElementById("studentForm");
            let adminForm = document.getElementById("adminForm");

            if (document.getElementById("studentRadio").checked) {
                studentForm.style.display = "block";
                adminForm.style.display = "none";
            } else {
                studentForm.style.display = "none";
                adminForm.style.display = "block";
            }
        }

        function showPopup(message, isSuccess) {
            const popupMessage = message;
            if (popupMessage) {
                alert(popupMessage);
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="card-header">
            <h1 class="card-title">Project Nightstay Portal</h1>
            <p class="card-subtitle">Student Registration & Admin Access</p>
        </div>
        <div class="card-body">
            <div class="login-options">
                <input type="radio" id="studentRadio" name="loginType" value="student" onclick="toggleForm()" checked>
                <label for="studentRadio">Student</label>
                <input type="radio" id="adminRadio" name="loginType" value="admin" onclick="toggleForm()">
                <label for="adminRadio">Admin</label>
            </div>

            <div id="studentForm" class="form-container">
                <h2 class="form-title">📝 Register for Nightstay</h2>
                <form action="User" method="post" class="form-grid">
                    <div class="form-group">
                        <label for="studentName">Name</label>
                        <input type="text" id="studentName" name="name" placeholder="Enter your full name" required>
                    </div>
                    <div class="form-group">
                        <label for="studentId">Student ID</label>
                        <input type="text" id="studentId" name="id" placeholder="Enter your student ID" required>
                    </div>
                    <div class="form-group">
                        <label for="studentYear">Year of Study</label>
                        <input type="text" id="studentYear" name="year" placeholder="e.g., First, Second" required>
                    </div>
                    <div class="form-group">
                        <label for="studentType">Hostel / Day Scholar</label>
                        <select id="studentType" name="type" class="form-select">
                            <option value="Hostel">Hostel</option>
                            <option value="Day Scholar">Day Scholar</option>
                        </select>
                    </div>
                    <button type="submit" class="submit-btn full-width">Register Nightstay</button>
                </form>
            </div>

            <div id="adminForm" class="form-container" style="display:none;">
                <h2 class="form-title">🔐 Admin Login</h2>
                <form action="Authentication" method="post" class="form-grid">
                    <div class="form-group">
                        <label for="adminName">Username</label>
                        <input type="text" id="adminName" name="name" placeholder="Enter your username" required>
                    </div>
                    <div class="form-group">
                        <label for="adminPassword">Password</label>
                        <input type="password" id="adminPassword" name="password" placeholder="Enter your password" required>
                    </div>
                    <button type="submit" class="submit-btn full-width">Login to Dashboard</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Call toggleForm on page load to set the initial state
        document.addEventListener('DOMContentLoaded', toggleForm);

        // This JSP scriptlet gets the session attributes and calls the JS function
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");

            if (successMessage != null) {
                out.println("showPopup('" + successMessage + "', true);");
                session.removeAttribute("successMessage");
            }
            if (errorMessage != null) {
                out.println("showPopup('" + errorMessage + "', false);");
                session.removeAttribute("errorMessage");
            }
        %>
    </script>
</body>
</html>