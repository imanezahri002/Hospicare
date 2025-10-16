package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Speciality;
import org.example.demo.repository.Interfaces.ISpecialityRepo;
import org.example.demo.repository.Interfaces.ISpecialityRepo;

import java.util.List;
import java.util.UUID;

public class SpecialityRepoImpl implements ISpecialityRepo {

    @Override
    public List<Speciality> findAll() {
        EntityManager em = PersistenceManager.getEntityManager();
        return em.createQuery("SELECT s FROM Speciality s JOIN FETCH s.departement", Speciality.class)
                .getResultList();
    }
    @Override
    public Speciality findById(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        return em.find(Speciality.class, id);
    }
    @Override
    public void save(Speciality speciality) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(speciality);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    public void update(Speciality speciality) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(speciality);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    @Override
    public void delete(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Speciality speciality = em.find(Speciality.class, id);
            if (speciality != null) em.remove(speciality);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
