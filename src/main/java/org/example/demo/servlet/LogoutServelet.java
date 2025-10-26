package org.example.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "logout", value = "/logout")
public class LogoutServelet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔹 Récupérer la session existante sans en créer une nouvelle
        HttpSession session = request.getSession(false);

        if (session != null) {
            // 🔹 Supprimer toutes les données de la session
            session.invalidate();
        }

        // 🔹 Redirection vers la page de login
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
