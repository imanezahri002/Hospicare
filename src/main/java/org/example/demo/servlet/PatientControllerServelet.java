package org.example.demo.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.entities.User;
import org.example.demo.service.impl.AppointementServiceImpl;
import org.example.demo.service.interfaces.AppointementService;
import org.example.demo.service.interfaces.PatientService;

import java.awt.datatransfer.DataFlavor;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/patient/*")
public class PatientControllerServelet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException,IOException{

        User loggedUser = (User) request.getSession().getAttribute("loggedUser");

        LocalDate dateSelect = LocalDate.parse(request.getParameter("dateSelect"));
        String specialityName = request.getParameter("specialityId");

        AppointementService appointementService=new AppointementServiceImpl();

        // On convertit specialityId en int si nécessaire

        var results = appointementService.findDoctorAndDispo(specialityName,dateSelect);

        // 3. Stocker les résultats dans l'objet request pour les afficher dans JSP
        request.setAttribute("availibilityDoctor", results);

        request.getRequestDispatcher("views/patient/dashboard.jsp")
                .forward(request, response);
    }

    }
