package org.example.demo.servlet;

import jakarta.persistence.EntityManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.demo.dto.auth.LoginDtoRequest;

import org.example.demo.dto.auth.LoginDtoResponse;
import org.example.demo.entities.Speciality;
import org.example.demo.entities.User;
import org.example.demo.mapper.UserMapper;
import org.example.demo.repository.Implement.UserRepoImpl;
import org.example.demo.repository.Interfaces.IUserRepo;
import org.example.demo.service.impl.AuthServiceImp;
import org.example.demo.service.impl.SpecialityServiceImpl;
import org.example.demo.service.interfaces.AuthService;
import org.example.demo.service.interfaces.SpecialityService;

import java.io.IOException;
import java.util.List;

@WebServlet(name="login",value = "/login")
public class LoginServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() {
        IUserRepo userRepository = new UserRepoImpl();
        authService = new AuthServiceImp(userRepository);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("views/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            LoginDtoRequest dto = new LoginDtoRequest(email, password);
            User user = authService.login(dto);

            if (user == null) {
                request.setAttribute("error", "Email ou mot de passe incorrect !");
                request.getRequestDispatcher("views/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            // ✅ 4. Rediriger selon le rôle
            switch (user.getRole()) {
                case ADMIN -> response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
                case DOCTOR -> response.sendRedirect(request.getContextPath() + "/views/doctor/dashboard.jsp");
                case PATIENT -> {
                    SpecialityService specialityService = new SpecialityServiceImpl();
                    List<Speciality> specialities = specialityService.getAllSpecialities();

                    request.setAttribute("specialities", specialities);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("views/patient/dashboard.jsp");
                    dispatcher.forward(request, response);
                }

                case STAFF -> response.sendRedirect(request.getContextPath() + "/views/staf/layout.jsp");
                default -> response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur interne : " + e.getMessage());
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

}
