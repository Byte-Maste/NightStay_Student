<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codewithkrishnachoudhary.POJO" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --card-background: #ffffff;
            --border-color: #ddd;
            --hover-bg: #f5f7f8;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 20px;
            color: #333;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: auto;
            background: var(--card-background);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .dashboard-header {
            text-align: center;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dashboard-title {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin: 0;
        }

        .user-greeting {
            color: #777;
            font-style: italic;
            font-size: 1rem;
            margin: 0;
            flex-grow: 1;
            text-align: right;
            padding-right: 15px;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .filter-section {
            background: #fafafa;
            border: 1px solid #e0e0e0;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .filter-title {
            margin-top: 0;
            font-size: 1.2rem;
            color: var(--secondary-color);
        }

        .filter-form {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-end;
            gap: 1rem;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-group label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #555;
        }

        .filter-section input {
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-size: 1rem;
        }

        .filter-btn {
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            background-color: #2ecc71;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .filter-btn:hover {
            background-color: #27ae60;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .student-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            min-width: 600px;
        }

        .student-table thead tr {
            background-color: var(--primary-color);
            color: white;
            text-align: left;
        }

        .student-table th, .student-table td {
            padding: 15px;
            border: 1px solid var(--border-color);
            white-space: nowrap;
        }

        .student-table tbody tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        .student-table tbody tr:hover {
            background-color: var(--hover-bg);
        }

        .no-records {
            text-align: center;
            font-style: italic;
            color: #888;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 1rem;
            }

            .dashboard-title {
                font-size: 2rem;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .user-greeting {
                text-align: left;
                padding-right: 0;
                margin-top: 5px;
            }

            .logout-btn {
                margin-top: 15px;
            }

            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
    <%
        // This is where the logout logic will be handled
        String action = request.getParameter("action");
        if ("logout".equals(action)) {

            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp");
            return;
        }

        // Authentication check for the dashboard
        POJO admin = null;
        if (session != null) {
            admin = (POJO)session.getAttribute("adminUser");
        }
        if (admin == null) {
            response.sendRedirect("index.jsp");
            return;
        }
    %>

    <div class="dashboard-container">
        <header class="dashboard-header">
            <div>
                <h1 class="dashboard-title">Admin Dashboard 📊</h1>

            </div>
            <form action="adminDashboard.jsp" method="get">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </header>

        <div class="filter-section">
            <h3 class="filter-title">Filter Student Records</h3>
            <form method="get" action="Admin" class="filter-form">
                <div class="filter-group">
                    <label for="fromDate">From Date:</label>
                    <input type="date" id="fromDate" name="fromDate" value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">
                </div>
                <div class="filter-group">
                    <label for="toDate">To Date:</label>
                    <input type="date" id="toDate" name="toDate" value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">
                </div>
                <div class="filter-group">
                    <label for="fromTime">From Time:</label>
                    <input type="time" id="fromTime" name="fromTime" value="<%= request.getParameter("fromTime") != null ? request.getParameter("fromTime") : "" %>">
                </div>
                <div class="filter-group">
                    <label for="toTime">To Time:</label>
                    <input type="time" id="toTime" name="toTime" value="<%= request.getParameter("toTime") != null ? request.getParameter("toTime") : "" %>">
                </div>
                <button type="submit" class="filter-btn">Apply Filter</button>
            </form>
        </div>

        <div class="table-responsive">
            <table class="student-table">
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Student ID</th>
                        <th>Year</th>
                        <th>Type</th>
                        <th>Date</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> students = (List<String[]>) request.getAttribute("students");
                        if (students != null && !students.isEmpty()) {
                            for (String[] student : students) {
                    %>
                    <tr>
                        <td><%= student[0] %></td>
                        <td><%= student[1] %></td>
                        <td><%= student[2] %></td>
                        <td><%= student[3] %></td>
                        <td><%= student[4] %></td>
                        <td><%= student[5] %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="no-records">No student records found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>