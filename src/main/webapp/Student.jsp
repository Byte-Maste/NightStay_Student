<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusConnect</title>
</head>
<body>
    <h2>Student Registration</h2>
    <form action="User" method="post">
        Name: <input type="text" name="name" required><br>
        Student ID: <input type="text" name="id" required><br>
        Year:
        <select name="year">
            <option value="1st">1st</option>
            <option value="2nd">2nd</option>
            <option value="3rd">3rd</option>
        </select><br>
        Type:
        <select name="type">
            <option value="Hosteller">Hosteller</option>
            <option value="Day Scholar">Day Scholar</option>
        </select><br>
        <button type="submit">Register</button>
    </form>
    <br>
    <a href="AdminServlet">Go to Admin Panel</a>
</body>
</html>
