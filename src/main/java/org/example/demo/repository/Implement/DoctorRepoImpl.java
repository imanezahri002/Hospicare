package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Doctor;
import org.example.demo.repository.Interfaces.IDoctorRepo;

import java.util.List;
import java.util.UUID;

public class DoctorRepoImpl implements IDoctorRepo {

    public void save(Doctor doctor) {

        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(doctor);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Doctor findById(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        Doctor doctor = null;

        try {
            doctor = em.find(Doctor.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return doctor;
    }

    public List<Doctor> findAll() {
        EntityManager em = PersistenceManager.getEntityManager();
        List<Doctor> doctors = null;

        try {
            TypedQuery<Doctor> query = em.createQuery("SELECT d FROM Doctor d", Doctor.class);
            doctors = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return doctors;
    }

    public void update(Doctor doctor) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.merge(doctor);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }


    public void delete(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null) {
                em.remove(doctor);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
