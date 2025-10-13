package org.example.demo.repositories.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Speciality;
import org.example.demo.repository.Interfaces.ISpecialityRepo;
import org.example.demo.repository.Interfaces.ISpecialityRepo;

import java.util.List;

public class SpecialityRepoImpl implements ISpecialityRepo {

    @Override
    public List<Speciality> findAll() {
        EntityManager em = PersistenceManager.getEntityManager();
        List<Speciality> results = null;

        try {
            TypedQuery<Speciality> query = em.createQuery(
                    "SELECT s FROM Speciality s", Speciality.class
            );
            results = query.getResultList();
        } finally {
            em.close();
        }
        return results;
    }
}
