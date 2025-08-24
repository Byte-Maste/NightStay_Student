package com.codewithkrishnachoudhary;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Admin")
public class Admin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            String sortOrder = "asc"; // default sorting

            // Get filter parameters from request
            String fromDate = req.getParameter("fromDate");
            String toDate = req.getParameter("toDate");
            String fromTime = req.getParameter("fromTime");
            String toTime = req.getParameter("toTime");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://127.0.0.1:3306/nightstay_student_incubation",
                    "root",
                    "vdkxxx"
            );

            // Build query
            StringBuilder query = new StringBuilder(
                    "SELECT Name, Id, year, Type, Date, Time FROM student_nightstay WHERE 1=1"
            );

            if (fromDate != null && !fromDate.isEmpty()) {
                query.append(" AND Date >= ?");
            }
            if (toDate != null && !toDate.isEmpty()) {
                query.append(" AND Date <= ?");
            }
            if (fromTime != null && !fromTime.isEmpty()) {
                query.append(" AND Time >= ?");
            }
            if (toTime != null && !toTime.isEmpty()) {
                query.append(" AND Time <= ?");
            }

            query.append(" ORDER BY Date ").append(sortOrder).append(", Time ").append(sortOrder);

            PreparedStatement ps = con.prepareStatement(query.toString());

            // Bind parameters
            int paramIndex = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(toDate));
            }
            if (fromTime != null && !fromTime.isEmpty()) {
                ps.setTime(paramIndex++, Time.valueOf(fromTime + ":00")); // add seconds
            }
            if (toTime != null && !toTime.isEmpty()) {
                ps.setTime(paramIndex++, Time.valueOf(toTime + ":00"));
            }

            ResultSet rs = ps.executeQuery();

            List<String[]> students = new ArrayList<>();
            while (rs.next()) {
                String[] data = new String[6];
                data[0] = rs.getString("Name");
                data[1] = rs.getString("Id");
                data[2] = rs.getString("year");
                data[3] = rs.getString("Type");
                data[4] = rs.getString("Date");
                data[5] = rs.getString("Time");
                students.add(data);
            }
            con.close();

            req.setAttribute("students", students);
            req.setAttribute("sortOrder", sortOrder);
            req.getRequestDispatcher("adminDashboard.jsp").forward(req, res);

        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
