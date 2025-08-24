package com.codewithkrishnachoudhary;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/Authentication")
public class Authentication extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String password = request.getParameter("password");

        // Hardcoded authentication for Admin
        if ("admin".equals(name) && "admin@123".equals(password)) {

            POJO adminUser = new POJO(name, password);
            HttpSession session = request.getSession();
            session.setAttribute("adminUser",adminUser);

              response.sendRedirect("adminDashboard.jsp");
        } else {
            out.println("<h3 style='color:red;'>Invalid Admin Credentials!</h3>");
            out.println("<a href='index.jsp'>Try Again</a>");

        }
    }
}
