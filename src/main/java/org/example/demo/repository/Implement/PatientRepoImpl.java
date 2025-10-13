package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Patient;
import org.example.demo.repository.Interfaces.IPatientRepo;

public class PatientRepoImpl implements IPatientRepo {


    @Override
    public void save(Patient patient) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();       // Démarrer la transaction
            em.persist(patient);       // Persiste le patient (et user lié automatiquement)
            transaction.commit();      // Valider la transaction
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback(); // Annuler en cas d'erreur
            }
            e.printStackTrace();
        } finally {
            em.close();                 // Toujours fermer l'EntityManager
        }
    }
}
