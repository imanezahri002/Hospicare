package org.example.demo.entities;

import jakarta.persistence.*;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "doctors")
public class Doctor extends User{
    @Id
    @GeneratedValue
    @UuidGenerator
    @Column(columnDefinition = "UUID")
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "speciality_id", nullable = false)
    private Speciality speciality;

    @Column(name = "matricule", nullable = false, unique = true)
    private String matricule;

    @Column(name = "titre", nullable = false)
    private String titre;

    // Constructeurs
    public Doctor() {}

    public Doctor(UUID id, String matricule, Speciality speciality,String titre) {
        this.id = id;
        this.matricule = matricule;
        this.speciality = speciality;
        this.titre=titre;
    }

    // Getters et Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

}
