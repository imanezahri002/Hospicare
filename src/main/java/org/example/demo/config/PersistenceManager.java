package org.example.demo.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class PersistenceManager {
    private static EntityManagerFactory emf;

    // 🧱 Méthode statique appelée une seule fois (Singleton)
    public static EntityManagerFactory getEntityManagerFactory() {
        if (emf == null) {
            emf = Persistence.createEntityManagerFactory("default");
        }
        return emf;
    }

    // 🧠 Méthode utilitaire pour obtenir un EntityManager
    public static EntityManager getEntityManager() {
        return getEntityManagerFactory().createEntityManager();
    }

    // 🚪 Fermer proprement la factory à la fin de l’application
    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
