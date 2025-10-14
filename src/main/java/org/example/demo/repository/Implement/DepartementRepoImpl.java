package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.PersistenceContext;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Departement;
import org.example.demo.repository.Interfaces.IDepartementRepo;

import java.util.List;

public class DepartementRepoImpl implements IDepartementRepo {
    @Override
    public void save(Departement departement) {

        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(departement);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    @Override
    public List<Departement> allDepartements() {
        EntityManager em = PersistenceManager.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Departement d", Departement.class)
                    .getResultList();
        } finally {
            em.close();
        }

    }
}
