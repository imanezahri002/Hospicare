package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.PersistenceContext;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Departement;
import org.example.demo.repository.Interfaces.IDepartementRepo;

import java.util.List;
import java.util.UUID;

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

    @Override
    public void update(Departement departement){
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try{
            transaction.begin();
            em.merge(departement);
            transaction.commit();
        }catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public Departement findById(UUID id){
        EntityManager em =PersistenceManager.getEntityManager();
        try{
            return em.find(Departement.class,id);
        }finally {
            em.close();
        }
    }
    @Override
    public void delete(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Departement departement = findById(id); // Trouver l'entité
            if (departement != null) {
                em.remove(departement); // Supprimer
            }
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

}
