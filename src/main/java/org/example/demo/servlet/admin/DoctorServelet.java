package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.entities.Doctor;
import org.example.demo.entities.Speciality;
import org.example.demo.entities.User;
import org.example.demo.entities.enums.Role;
import org.example.demo.repository.Implement.UserRepoImpl;
import org.example.demo.service.impl.DoctorServiceImpl;
import org.example.demo.service.impl.SpecialityServiceImpl;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(value = "/admin/doctors")
public class DoctorServelet extends HttpServlet {
    private final DoctorServiceImpl doctorService = new DoctorServiceImpl();
    private final SpecialityServiceImpl specialityService = new SpecialityServiceImpl();
    private final UserRepoImpl userRepo=new UserRepoImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                deleteDoctor(req, resp);
                break;
            default: // "list" par défaut
                listDoctors(req, resp);
                break;
        }
//

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if(req.getParameter("id") == null || req.getParameter("id").isEmpty()) {
            createDoctor(req, resp);
        }else{
            updateDoctor(req, resp);
        }
    }

    private void listDoctors(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Doctor> doctors = doctorService.findAll();
        List<Speciality> specialities = specialityService.getAllSpecialities();

        req.setAttribute("specialities", specialities);
        req.setAttribute("doctors", doctors);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/doctors.jsp");
        dispatcher.forward(req, resp);
    }

    private void createDoctor(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String name=req.getParameter("full_name");
        String email=req.getParameter("email");
        String password=req.getParameter("password");
        String telephone=req.getParameter("telephone");
        UUID speciality_id=UUID.fromString(req.getParameter("speciality_id"));
        boolean active = "active".equals(req.getParameter("status"));
        String titre=req.getParameter("titre");
        String matricule=req.getParameter("matricule");

        Speciality speciality = specialityService.getSpecialityById(speciality_id);

        Doctor doctor=new Doctor();
        doctor.setFullName(name);
        doctor.setEmail(email);
        doctor.setTel(telephone);
        doctor.setSpeciality(speciality);
        doctor.setIs_active(active);
        doctor.setPassword(password);
        doctor.setRole(Role.DOCTOR);
        doctor.setTitre(titre);
        doctor.setMatricule(matricule);


        doctorService.saveDoctor(doctor);
        resp.sendRedirect(req.getContextPath() + "/admin/doctors?action=list");

    }
    private void updateDoctor(HttpServletRequest req,HttpServletResponse resp)
            throws IOException {

        System.out.println("hello world");

        UUID id_doctor=UUID.fromString(req.getParameter("id"));
        System.out.println(id_doctor);

        String name=req.getParameter("full_name");
        String email=req.getParameter("email");
        String password=req.getParameter("password");
        String telephone=req.getParameter("telephone");
        UUID speciality_id=UUID.fromString(req.getParameter("speciality_id"));
        boolean active = "active".equals(req.getParameter("status"));
        String titre=req.getParameter("titre");
        String matricule=req.getParameter("matricule");

        Speciality speciality = specialityService.getSpecialityById(speciality_id);
        Doctor doctor=doctorService.findById(id_doctor);

        doctor.setFullName(name);
        doctor.setEmail(email);
        doctor.setTel(telephone);
        doctor.setSpeciality(speciality);
        doctor.setIs_active(active);
        doctor.setPassword(password);
        doctor.setRole(Role.DOCTOR);
        doctor.setTitre(titre);
        doctor.setMatricule(matricule);

        doctorService.updateDoctor(doctor);
        resp.sendRedirect(req.getContextPath() + "/admin/doctors?action=list");
    }

    private void deleteDoctor(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        doctorService.deleteDoctor(id);
        resp.sendRedirect(req.getContextPath() + "/admin/doctors?action=list");

    }






}
