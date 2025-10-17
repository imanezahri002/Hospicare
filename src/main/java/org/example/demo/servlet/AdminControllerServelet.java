package org.example.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.entities.Speciality;
import org.example.demo.service.impl.DepartementServiceImpl;
import org.example.demo.service.impl.SpecialityServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminControllerServelet extends HttpServlet {
    private final SpecialityServiceImpl specialityService = new SpecialityServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if ("/patients".equals(path)) {
            request.getRequestDispatcher("/views/admin/patients.jsp").forward(request, response);
            return;

        } else if ("/departements".equals(path)) {
            List<DepartementDtoResponse> departements = new DepartementServiceImpl().findAllDepartement();
            request.setAttribute("departements", departements);
            request.getRequestDispatcher("/views/admin/departements.jsp").forward(request, response);
            return;

        } else if ("/speciality".equals(path)) {
            List<Speciality> specialities = specialityService.getAllSpecialities();
            List<DepartementDtoResponse> departements = new DepartementServiceImpl().findAllDepartement();

            request.setAttribute("departements", departements);
            request.setAttribute("specialities", specialities);

            request.getRequestDispatcher("/views/admin/speciality.jsp").forward(request, response);
            return;
        }else if ("/doctors".equals(path)){
            List<Speciality> specialities = specialityService.getAllSpecialities();
            List<DepartementDtoResponse> departements = new DepartementServiceImpl().findAllDepartement();

            request.setAttribute("departements", departements);
            request.setAttribute("specialities", specialities);

            request.getRequestDispatcher("/views/admin/doctors.jsp").forward(request, response);
            return;
        }

        // ✅ si aucun path ne correspond → tableau de bord
        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}
