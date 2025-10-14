package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.service.impl.DepartementServiceImpl;
import org.example.demo.service.interfaces.DepartementService;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/addDepartment")
public class DepartementAddServelet extends HttpServlet {
    private final DepartementService departementService=new DepartementServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            DepartementDtoRequest departementDto = new DepartementDtoRequest();
            departementDto.setNom(request.getParameter("name"));
            departementDto.setCode(request.getParameter("code"));
            departementDto.setDescription(request.getParameter("description"));
            departementDto.setIs_active(Boolean.parseBoolean(request.getParameter("status")));

        if(request.getParameter("id") == null || request.getParameter("id").isEmpty()) {
            departementService.addDepartement(departementDto);
        }else{

            departementDto.setId(UUID.fromString(request.getParameter("id")));
            departementService.updateDepartement(departementDto);
        }

        response.sendRedirect(request.getContextPath() + "/controller?page=departements");


    }
}
