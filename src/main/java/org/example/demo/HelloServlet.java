package org.example.demo;

import java.io.*;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;
    private static EntityManagerFactory emf;
    public void init() {
        emf = Persistence.createEntityManagerFactory("default");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try{

            EntityManager em = emf.createEntityManager();
            PrintWriter out = response.getWriter();

            em.getTransaction().begin();
            response.setContentType("text/html");
            em.getTransaction().commit();
            em.close();
            out.println("<h1>Connected !</h1>");


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void destroy() {
    }
}