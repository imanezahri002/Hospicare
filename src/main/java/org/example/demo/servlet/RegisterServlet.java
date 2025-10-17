package org.example.demo.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.Patient.PatientDtoRequest;
import org.example.demo.entities.Patient;
import org.example.demo.entities.Speciality;
import org.example.demo.repository.Implement.PatientRepoImpl;
import org.example.demo.repository.Implement.SpecialityRepoImpl;
import org.example.demo.repository.Interfaces.IPatientRepo;
import org.example.demo.repository.Interfaces.ISpecialityRepo;
import org.example.demo.mapper.PatientMapper;
import org.example.demo.service.impl.PatientServiceImpl;
import org.example.demo.service.interfaces.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name="register",value = "/register")

public class RegisterServlet extends HttpServlet{

    private final IPatientRepo patientRepository = new PatientRepoImpl();

    private final ISpecialityRepo specialityRepo = new SpecialityRepoImpl();
    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
        dispatcher.forward(request, response);

            }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");

        if ("PATIENT".equalsIgnoreCase(role)) {

            // 🔹 Création du DTO
            PatientDtoRequest patientDto = new PatientDtoRequest();
            patientDto.setFullName(request.getParameter("fullName"));
            patientDto.setEmail(request.getParameter("email"));
            patientDto.setPassword(request.getParameter("password"));
            patientDto.setCin(request.getParameter("cin"));
            patientDto.setAddress(request.getParameter("address"));
            patientDto.setTelephone(request.getParameter("phone"));
            patientDto.setSang(request.getParameter("bloodGroup"));
            patientDto.setSexe(request.getParameter("sexe"));



            String birthDateStr = request.getParameter("birthDate");
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                patientDto.setBirthDate(LocalDate.parse(birthDateStr));
            }

            // 🔹 Mapper vers entité
            Patient patient = PatientMapper.toEntity(patientDto);

            // 🔹 Sauvegarder en base
            patientRepository.save(patient);

            // 🔹 Redirection vers la page de connexion
            System.out.println("success");
            response.sendRedirect(request.getContextPath() + "/login");

        } else {
            // Si le rôle n’est pas patient, on renvoie simplement vers le formulaire
            response.sendRedirect(request.getContextPath() + "/register");
        }
    }
}
