package org.example.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/controller")
public class AdminControllerServelet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");
        String contentPage = "dashboard.jsp"; // défaut

        if ("users".equals(page)) {
            contentPage = "users.jsp";
        } else if ("departements".equals(page)) {
            contentPage = "departements.jsp";
        }else if("speciality".equals(page)){
            contentPage="speciality.jsp";
        }

        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("views/admin/layout.jsp").forward(request, response);
    }
}
