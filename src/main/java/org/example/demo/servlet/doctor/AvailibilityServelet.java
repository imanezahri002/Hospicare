package org.example.demo.servlet.doctor;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;
import org.example.demo.entities.User;
import org.example.demo.entities.enums.Jour;
import org.example.demo.entities.enums.StatutAvailibility;
import org.example.demo.repository.Implement.DoctorRepoImpl;
import org.example.demo.service.impl.AvailibilityServiceImpl;
import org.example.demo.service.impl.DoctorServiceImpl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;


@WebServlet("/doctor/availibility")
public class AvailibilityServelet extends HttpServlet {

    private final AvailibilityServiceImpl availibilityService = new AvailibilityServiceImpl();
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    private final DoctorServiceImpl doctorService = new DoctorServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "toggleStatus":
                changeStatusAvailibility(req, resp);
                break;
            default: // "list" par défaut
                listAvailibilities(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if(req.getParameter("id") == null || req.getParameter("id").isEmpty()) {
            createAvailibility(req, resp);
        } else {
            updateAvailibility(req, resp);
        }

    }

    private void listAvailibilities(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User loggedUser = (User) req.getSession().getAttribute("loggedUser");

        List<Availibility> availibilities = availibilityService.findAvailibilityByDoctor(loggedUser.getId());

        req.setAttribute("availibilities", availibilities);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/doctor/availibility.jsp");
        dispatcher.forward(req, resp);
    }

    private void createAvailibility(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        System.out.println("hello create");

        String jour = req.getParameter("jour");
        String heureDebut = req.getParameter("heureDebut");
        String heureFin = req.getParameter("heureFin");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        String statut = req.getParameter("statut");
        System.out.println(dateDebut);

        User loggedUser = (User) req.getSession().getAttribute("loggedUser");

        Availibility availability = new Availibility();
        availability.setJour(Jour.valueOf(jour));
        availability.setHeureDebut(LocalTime.parse(heureDebut));
        availability.setHeureFin(LocalTime.parse(heureFin));
        availability.setDateDebut(dateDebut != null && !dateDebut.isEmpty() ? LocalDate.parse(dateDebut) : null);
        availability.setDateFin(dateFin != null && !dateFin.isEmpty() ? LocalDate.parse(dateFin) : null);
        availability.setStatut(StatutAvailibility.valueOf(statut));

        Doctor doctor=doctorService.findById(loggedUser.getId());

        availability.setDoctor(doctor);
        availibilityService.save(availability);

        resp.sendRedirect(req.getContextPath() + "/doctor/availibility?action=list");

    }

    private void updateAvailibility(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        System.out.println("hello update");

        String id = req.getParameter("id");
        Availibility availability = availibilityService.findById(UUID.fromString(id));

        String jour = req.getParameter("jour");
        String heureDebut = req.getParameter("heureDebut");
        String heureFin = req.getParameter("heureFin");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        String statut = req.getParameter("statut");

        availability.setJour(Jour.valueOf(jour));
        availability.setHeureDebut(LocalTime.parse(heureDebut));
        availability.setHeureFin(LocalTime.parse(heureFin));
        availability.setDateDebut(dateDebut != null && !dateDebut.isEmpty() ? LocalDate.parse(dateDebut) : null);
        availability.setDateFin(dateFin != null && !dateFin.isEmpty() ? LocalDate.parse(dateFin) : null);
        availability.setStatut(StatutAvailibility.valueOf(statut));

        availibilityService.update(availability);

        resp.sendRedirect(req.getContextPath() + "/doctor/availibility?action=list");
    }

    private void changeStatusAvailibility(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("hello change");
        String id = req.getParameter("id");
        String statut = req.getParameter("status");

        System.out.println("Statut reçu: " + statut);
        System.out.println("ID reçu: " + id);



        if(id != null && statut != null) {
            Availibility availability = availibilityService.findById(UUID.fromString(id));
            if(availability != null){
                availability.setStatut(StatutAvailibility.valueOf(statut));
                availibilityService.update(availability);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/doctor/availibility?action=list");
    }


//    private void deleteAvailibility(HttpServletRequest req, HttpServletResponse resp)
//            throws IOException {
//
//        UUID id = UUID.fromString(req.getParameter("id"));
//        availibilityService.delete(id);
//        resp.sendRedirect(req.getContextPath() + "/admin/availibilities?action=list");
//    }


}
