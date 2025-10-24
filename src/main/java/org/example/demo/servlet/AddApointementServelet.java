package org.example.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.entities.Appointement;
import org.example.demo.entities.Doctor;
import org.example.demo.entities.Patient;
import org.example.demo.entities.User;
import org.example.demo.entities.enums.StatutAppointement;
import org.example.demo.entities.enums.TypeAppointement;
import org.example.demo.service.impl.AppointementServiceImpl;
import org.example.demo.service.impl.DoctorServiceImpl;
import org.example.demo.service.impl.PatientServiceImpl;
import org.example.demo.service.interfaces.AppointementService;
import org.example.demo.service.interfaces.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;


@WebServlet("/addAppointment")
public class AddApointementServelet extends HttpServlet {
    private final AppointementService appointementService = new AppointementServiceImpl();

    private final DoctorServiceImpl doctorService = new DoctorServiceImpl();
    private final PatientService patientService=new PatientServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User loggedUser = (User) request.getSession().getAttribute("loggedUser");
            if (loggedUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            String doctorIdParam = request.getParameter("doctorId");
            String slotParam = request.getParameter("slot");
            String dateParam = request.getParameter("date");
            System.out.println(dateParam);

            if (doctorIdParam == null || slotParam == null || dateParam == null) {
                throw new IllegalArgumentException("Champs manquants dans le formulaire !");
            }

            UUID doctorId = UUID.fromString(doctorIdParam);

            LocalTime heureDebut = LocalTime.parse(slotParam);
            LocalTime heureFin = heureDebut.plusMinutes(30);
            LocalDate date = LocalDate.parse(dateParam);
            Appointement appointment = new Appointement();
            Doctor doctor=doctorService.findById(doctorId);
            appointment.setDoctor(doctor);
            Patient patient=patientService.findById(loggedUser.getId());
            appointment.setPatient(patient);
            appointment.setDateDebut(date);
            appointment.setDateFin(date);
            appointment.setHeureDebut(heureDebut);
            appointment.setHeureFin(heureFin);
            appointment.setStatut(StatutAppointement.PENDING); // Enum ou String selon ton modèle
            appointment.setType(TypeAppointement.CONSULTATION);
            appointementService.addAppointment(appointment);

            request.getSession().setAttribute("successMsg", "Rendez-vous ajouté avec succès !");

            List<Appointement> appointments = appointementService.findAppointements(patient.getId());

            request.setAttribute("appointments", appointments);

            request.getRequestDispatcher("views/patient/appointements.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Erreur lors de l'ajout du rendez-vous : " + e.getMessage());
            response.sendRedirect("views/patient/dashboard.jsp");
        }
    }
}
