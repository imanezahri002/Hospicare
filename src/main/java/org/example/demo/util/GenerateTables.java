package org.example.demo.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class GenerateTables {
    public static void main(String[] args) {
        try{
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");
            emf.close();
            System.out.println("Tables should now be created in your database!");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
