package org.example.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.service.impl.DepartementServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/controller")
public class AdminControllerServelet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");
        String contentPage = "dashboard.jsp"; // défaut

        if ("users".equals(page)) {
            contentPage = "users.jsp";
        } else if ("departements".equals(page)) {
            List<DepartementDtoResponse> departements = new DepartementServiceImpl().findAllDepartement();
            request.setAttribute("departements", departements);

            contentPage = "/views/admin/departements.jsp";
            contentPage = "departements.jsp";
        }else if("speciality".equals(page)){
            contentPage="speciality.jsp";
        }

        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher("views/admin/layout.jsp").forward(request, response);
    }
}
