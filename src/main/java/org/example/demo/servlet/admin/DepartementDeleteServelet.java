package org.example.demo.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.service.impl.DepartementServiceImpl;
import org.example.demo.service.interfaces.DepartementService;

import java.io.IOException;
import java.util.UUID;
@WebServlet("/deleteDepartment")
public class DepartementDeleteServelet extends HttpServlet {
    private final DepartementService departementService = new DepartementServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            UUID id = UUID.fromString(idStr); // conversion string -> UUID
            departementService.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/controller?page=departements");

    }
}
