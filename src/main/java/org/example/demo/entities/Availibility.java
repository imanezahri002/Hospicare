package org.example.demo.entities;


import jakarta.persistence.*;
import org.example.demo.entities.enums.Jour;
import org.example.demo.entities.enums.StatutAvailibility;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalTime;
import java.util.UUID;


@Entity
public class Availibility {
   @Id
   @GeneratedValue(generator = "UUID")
   @UuidGenerator
   @Column(name = "id", updatable = false, nullable = false)
   private UUID id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Jour jour;

    @Column(nullable = false)
    private LocalTime heureDebut;

    @Column(nullable = false)
    private LocalTime heureFin;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutAvailibility statut;

    @Column(nullable = false)
    private boolean validite;

    // Relation avec Doctor
    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    // Getters et Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public Jour getJour() {
        return jour;
    }

    public void setJour(Jour jour) {
        this.jour = jour;
    }

    public LocalTime getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(LocalTime heureDebut) {
        this.heureDebut = heureDebut;
    }

    public LocalTime getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(LocalTime heureFin) {
        this.heureFin = heureFin;
    }

    public StatutAvailibility getStatut() {
        return statut;
    }

    public void setStatut(StatutAvailibility statut) {
        this.statut = statut;
    }

    public boolean isValidite() {
        return validite;
    }

    public void setValidite(boolean validite) {
        this.validite = validite;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }


}
