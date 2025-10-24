package org.example.demo.repository.Implement;

import jakarta.persistence.EntityTransaction;
import org.example.demo.entities.Appointement;
import org.example.demo.entities.enums.StatutAppointement;
import org.example.demo.entities.enums.StatutAvailibility;
import org.example.demo.repository.Interfaces.IAppointementRepo;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

public class AppointementRepoImpl implements IAppointementRepo {

    @Override
    public Map<Doctor, List<LocalTime>> findDoctorAndDispoBySpecialityDate(String specialityName, LocalDate date) {
            EntityManager em = PersistenceManager.getEntityManager();
            Map<Doctor, List<LocalTime>> result = new HashMap<>();
            try {
                  // 1️⃣ Récupérer les docteurs actifs de cette spécialité
                TypedQuery<Doctor> doctorQuery = em.createQuery(
                        "SELECT d FROM Doctor d WHERE d.speciality.nom = :specialityName AND d.is_active = true",
                        Doctor.class
                );
                doctorQuery.setParameter("specialityName", specialityName);
                List<Doctor> doctors = doctorQuery.getResultList();
                System.out.println(doctors);

                 // 2️⃣ Pour chaque docteur, récupérer ses disponibilités valides pour la date donnée
                for (Doctor doctor : doctors) {
                    TypedQuery<Availibility> availQuery = em.createQuery(
                            "SELECT a FROM Availibility a " +
                                    "WHERE a.doctor.id = :doctor " +
                                    "AND a.validite = false " +
                                    "AND a.statut = :statut " +
                                    "AND a.dateDebut <= :date  "+
                                    "AND a.dateFin >= :date",
                            Availibility.class

                    );

                    availQuery.setParameter("doctor", doctor.getId());
                    availQuery.setParameter("statut", StatutAvailibility.AVAILABLE);
                    availQuery.setParameter("date", date); // date est un java.time.LocalDate

                    List<Availibility> availabilities = availQuery.getResultList();
                    List<LocalTime> allSlots = new ArrayList<>();
                    for (Availibility a : availabilities) {
                        allSlots.addAll(generateTimeSlots(a.getHeureDebut(), a.getHeureFin()));
                    }

                    List<LocalTime> reservedTimes = getReservedTimes(doctor.getId(), date);
                    allSlots.removeAll(reservedTimes);

                    result.put(doctor, allSlots);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                em.close();
            }
            return result;
        }

    public List<LocalTime> generateTimeSlots(LocalTime start, LocalTime end) {
        List<LocalTime> slots = new ArrayList<>();
        Duration slotDuration = Duration.ofMinutes(30); // durée de chaque créneau
        Duration breakDuration = Duration.ofMinutes(5); // pause entre les créneaux

        LocalTime current = start;

        while (current.isBefore(end) || current.equals(end)) {
            // calculer la fin du créneau actuel
            LocalTime slotEnd = current.plus(slotDuration);
            if (slotEnd.isAfter(end)) {
                slotEnd = end; // ne pas dépasser l'heure de fin
            }
            slots.add(slotEnd); // on ajoute l'heure de fin du créneau

            // passer au créneau suivant
            current = slotEnd.plus(breakDuration);
            if (current.isAfter(end)) {
                break; // si on dépasse l'heure de fin, on sort
            }
        }

        return slots;
    }

    @Override
    public void save(Appointement appointment) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(appointment);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
         } finally {
            em.close();
        }
    }

    @Override
    public List<Appointement> findByPatientId(UUID patientId) {
            EntityManager em = PersistenceManager.getEntityManager();
            List<Appointement> appointments = null;

            try {
                appointments = em.createQuery(
                                "SELECT a FROM Appointement a WHERE a.patient.id = :pid",
                                Appointement.class
                        )
                        .setParameter("pid", patientId)
                        .getResultList();

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                em.close();
            }

            return appointments;
        }

    public List<LocalTime> getReservedTimes(UUID doctorId, LocalDate date) {
        EntityManager em = PersistenceManager.getEntityManager();
        List<LocalTime> reservedTimes = new ArrayList<>();
        try {
            TypedQuery<LocalTime> query = em.createQuery(
                    "SELECT a.heureDebut FROM Appointement a " +
                            "WHERE a.doctor.id = :doctorId " +
                            "AND a.statut = :statut " +
                            "AND :date BETWEEN a.dateDebut AND a.dateFin",
                    LocalTime.class
            );
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("statut", StatutAppointement.PENDING);

            reservedTimes = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return reservedTimes;
    }



}
