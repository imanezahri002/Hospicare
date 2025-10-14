package org.example.demo.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.service.impl.DepartementServiceImpl;
import org.example.demo.service.interfaces.DepartementService;

import java.io.IOException;

@WebServlet("/addDepartment")
public class DepartementAddServelet extends HttpServlet {
    private final DepartementService departementService=new DepartementServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepartementDtoRequest departementDto=new DepartementDtoRequest();
        departementDto.setNom(request.getParameter("name"));
        departementDto.setCode(request.getParameter("code"));
        departementDto.setDescription(request.getParameter("description"));

        departementService.addDepartement(departementDto);
        request.getRequestDispatcher("/views/success.jsp").forward(request, response);



    }
}
