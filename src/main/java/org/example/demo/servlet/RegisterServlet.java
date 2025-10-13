package org.example.demo.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.speciality.SpecialityDtoResponse;
import org.example.demo.entities.Speciality;
import org.example.demo.mapper.SpecialityMapper;
import org.example.demo.repository.Interfaces.ISpecialityRepo;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name="register",value = "/register")
public class RegisterServlet extends HttpServlet{

    private final ISpecialityRepo specialityRepo = new org.example.demo.repositories.impl.SpecialityRepoImpl();
    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        // 📦 Récupérer toutes les spécialités depuis la DB
        List<Speciality> specialities = specialityRepo.findAll();

        // 🎯 Mapper en ResponseDTO (pour afficher dans JSP)
        List<SpecialityDtoResponse> specialityDTOs = specialities.stream()
                .map(SpecialityMapper::toResponseDTO)
                .collect(Collectors.toList());

        // 🔗 Envoyer à la vue
        request.setAttribute("specialities", specialityDTOs);
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);


            }
}
