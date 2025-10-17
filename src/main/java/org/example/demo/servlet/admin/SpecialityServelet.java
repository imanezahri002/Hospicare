package org.example.demo.servlet.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.entities.Departement;
import org.example.demo.entities.Speciality;
import org.example.demo.service.impl.DepartementServiceImpl;
import org.example.demo.service.impl.SpecialityServiceImpl;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/specialities")
public class SpecialityServelet extends HttpServlet {

    private final SpecialityServiceImpl specialityService = new SpecialityServiceImpl();
    private final DepartementServiceImpl departementService = new DepartementServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                deleteSpeciality(req, resp);
                break;
            default: // "list" par défaut
                listSpecialities(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if(req.getParameter("id") == null || req.getParameter("id").isEmpty()) {
            createSpeciality(req, resp);
        }else{
            updateSpeciality(req, resp);
        }
    }

    private void listSpecialities(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Speciality> specialities = specialityService.getAllSpecialities();
        List<DepartementDtoResponse> departements = departementService.findAllDepartement();

        req.setAttribute("specialities", specialities);
        req.setAttribute("departements", departements);

        RequestDispatcher dispatcher = req.getRequestDispatcher("views/admin/speciality.jsp");
        dispatcher.forward(req, resp);
    }

    private void createSpeciality(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String name = req.getParameter("name");
        String code = req.getParameter("code");
        String description = req.getParameter("description");
        String departmentId = req.getParameter("departmentId");
        boolean active = "active".equals(req.getParameter("status"));

        Departement departement = new Departement();
        departement.setId(UUID.fromString(departmentId));

        Speciality speciality = new Speciality();
        speciality.setNom(name);
        speciality.setCode(code);
        speciality.setDescription(description);
        speciality.setDepartement(departement);
        speciality.setIs_active(active);

        specialityService.addSpeciality(speciality);
        resp.sendRedirect(req.getContextPath() + "/admin/speciality?action=list");
    }

    private void updateSpeciality(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {


        UUID id = UUID.fromString(req.getParameter("id"));
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        String description = req.getParameter("description");
        String departmentId = req.getParameter("departmentId");
        boolean active = "active".equals(req.getParameter("status"));
        UUID idDepartement=UUID.fromString(req.getParameter("departmentId"));

        Departement departement=departementService.findDepartement(idDepartement);

        Speciality speciality = specialityService.getSpecialityById(id);

        speciality.setNom(name);
        speciality.setCode(code);
        speciality.setDescription(description);
        speciality.setDepartement(departement);
        speciality.setIs_active(active);
        specialityService.updateSpeciality(speciality);
        resp.sendRedirect(req.getContextPath() + "/admin/speciality?action=list");
    }

    private void deleteSpeciality(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        UUID id = UUID.fromString(req.getParameter("id"));
        specialityService.deleteSpeciality(id);
        resp.sendRedirect(req.getContextPath() + "/admin/speciality?action=list");

    }
}
