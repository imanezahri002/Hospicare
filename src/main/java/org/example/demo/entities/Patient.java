package org.example.demo.entities;

import jakarta.persistence.*;
import org.example.demo.entities.enums.GroupSanguin;
import org.example.demo.entities.enums.Role;
import org.example.demo.entities.enums.Sexe;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "patients")
@PrimaryKeyJoinColumn(name = "user_id")
public class Patient extends User{


    @Id
    @GeneratedValue(generator = "UUID")
    @UuidGenerator
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;


    @Column(name = "cin", nullable = false, unique = true)
    private String cin;

    @Column(name = "birthdate", nullable = false)
    private LocalDate bithdate;

    @Column(name = "adresse")
    private String adresse;

    @Column(name = "telephone")
    private String telephone;

    @Enumerated(EnumType.STRING)
    @Column(name = "groupe_sanguin")
    private GroupSanguin sang;

    @Enumerated(EnumType.STRING)
    @Column(name="sexe")
    private Sexe sexe;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Patient() {}

    // Constructeur qui appelle super()
    public Patient(String email, String password, String fullName, Role role,
                   String cin, LocalDate bithdate, Sexe sexe,
                   String adresse, String telephone, GroupSanguin sang) {
        super(email,password,fullName,role);
        this.cin = cin;
        this.bithdate = bithdate;
        this.sexe = sexe;
        this.adresse = adresse;
        this.telephone = telephone;
        this.sang = sang;
    }

    @Override
    public UUID getId() {
        return id;
    }

    @Override
    public void setId(UUID id) {
        this.id = id;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public LocalDate getBithdate() {
        return bithdate;
    }

    public void setBithdate(LocalDate bithdate) {
        this.bithdate = bithdate;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public GroupSanguin getSang() {
        return sang;
    }

    public void setSang(GroupSanguin sang) {
        this.sang = sang;
    }

    public Sexe getSexe() {
        return sexe;
    }

    public void setSexe(Sexe sexe) {
        this.sexe = sexe;
    }

}
