package org.example.demo.servlet;

import jakarta.persistence.EntityManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.demo.dto.auth.LoginDtoRequest;

import org.example.demo.dto.auth.LoginDtoResponse;
import org.example.demo.entities.User;
import org.example.demo.mapper.UserMapper;
import org.example.demo.repository.Implement.UserRepoImpl;
import org.example.demo.repository.Interfaces.IUserRepo;
import org.example.demo.service.impl.AuthServiceImp;
import org.example.demo.service.interfaces.AuthService;

import java.io.IOException;

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

        // 1️⃣ Récupérer les données du formulaire
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            LoginDtoRequest dto = new LoginDtoRequest(email, password);
            LoginDtoResponse user = authService.login(dto);

            request.setAttribute("user", user);
            request.getSession().setAttribute("loggedUser", user);
            // Redirection selon le rôle
            switch (user.getRole()) {
                case ADMIN -> response.sendRedirect(request.getContextPath() + "views/admin/layout.jsp");
                case DOCTOR -> response.sendRedirect(request.getContextPath() + "views/doctor/layout.jsp");
                case PATIENT -> response.sendRedirect(request.getContextPath() + "views/patient/layout.jsp");
                case STAFF -> response.sendRedirect(request.getContextPath()+"views/staf/layout.jsp");
                default -> response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

}
