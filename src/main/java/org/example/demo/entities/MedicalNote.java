package org.example.demo.entities;

import jakarta.persistence.*;
import org.hibernate.annotations.UuidGenerator;

import java.util.UUID;

@Entity
@Table(name = "medical_notes")

public class MedicalNote {
    @Id
    @GeneratedValue(generator = "UUID")
    @UuidGenerator
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String contenu;

    @OneToOne
    @JoinColumn(name = "appointement_id", nullable = false, unique = true)
    private Appointement appointement;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public Appointement getAppointement() {
        return appointement;
    }

    public void setAppointement(Appointement appointement) {
        this.appointement = appointement;
    }
}
