package org.example.demo.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.entities.Appointement;
import org.example.demo.entities.Patient;
import org.example.demo.entities.User;
import org.example.demo.service.impl.AppointementServiceImpl;
import org.example.demo.service.impl.PatientServiceImpl;
import org.example.demo.service.interfaces.AppointementService;
import org.example.demo.service.interfaces.PatientService;

import java.io.IOException;
import java.util.List;

@WebServlet("/rendezVous")
public class AppointementListServelet extends HttpServlet {

    private final AppointementService appointementService = new AppointementServiceImpl();
    private final PatientService patientService=new PatientServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User loggedUser = (User) request.getSession().getAttribute("loggedUser");
        if (loggedUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Patient patient=patientService.findById(loggedUser.getId());

        List<Appointement> appointments = appointementService.findAppointements(patient.getId());

        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("/views/patient/appointements.jsp").forward(request, response);

        System.out.println(appointments);
        return;


    }


    }
