package com.codewithkrishnachoudhary;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.LocalTime;


@WebServlet("/User")
public class User extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        String id = request.getParameter("id");
        String year = request.getParameter("year");
        String type = request.getParameter("type");

        // Get current date and time
        LocalDate date = LocalDate.now();
        LocalTime time = LocalTime.now();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://127.0.0.1:3306/nightstay_student_incubation", "root", "vdkxxx");

            String query = "INSERT INTO student_nightstay (Name, Id, year, Type, Date, Time) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, id);
            ps.setString(3, year);
            ps.setString(4, type);
            ps.setDate(5, java.sql.Date.valueOf(date)); // DATE column
            ps.setTime(6, java.sql.Time.valueOf(time)); // TIME column

            int i = ps.executeUpdate();
            if (i > 0) {
                // Set a session attribute to indicate success
                session.setAttribute("successMessage", "Registration Successful! Welcome, " + name + ".");
            } else {
                session.setAttribute("errorMessage", "Failed to register. Please try again.");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace(out);
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        // Redirect back to the login page
        response.sendRedirect("index.jsp");
    }
}