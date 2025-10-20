package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Availibility;
import org.example.demo.repository.Interfaces.IAvailibilityRepo;

import java.util.List;
import java.util.UUID;

public class AvailibilityRepoImpl implements IAvailibilityRepo {

    @Override
    public void save(Availibility availibility) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(availibility);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public Availibility findById(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        Availibility availibility = null;

        try {
            availibility = em.find(Availibility.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return availibility;
    }

    @Override
    public List<Availibility> findAll() {
        EntityManager em = PersistenceManager.getEntityManager();
        List<Availibility> availibilities = null;

        try {
            TypedQuery<Availibility> query = em.createQuery("SELECT a FROM Availibility a", Availibility.class);
            availibilities = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return availibilities;
    }

    @Override
    public void update(Availibility availibility) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.merge(availibility);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            Availibility availibility = em.find(Availibility.class, id);
            if (availibility != null) {
                em.remove(availibility);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override

    public List<Availibility> findByDoctorId(UUID doctorId) {
        EntityManager em = PersistenceManager.getEntityManager();
        List<Availibility> availibilities = null;

        try {
            TypedQuery<Availibility> query = em.createQuery(
                    "SELECT a FROM Availibility a WHERE a.doctor.id = :doctorId", Availibility.class);
            query.setParameter("doctorId", doctorId);
            availibilities = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return availibilities;
    }


}
