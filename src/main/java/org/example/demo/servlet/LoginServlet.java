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
            request.getRequestDispatcher("views/success.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

}
