package org.example.demo.entities;

import jakarta.persistence.*;
import org.example.demo.entities.enums.Role;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "doctors")

@PrimaryKeyJoinColumn(name="user_id")
public class Doctor extends User{
//    @Id
//    @GeneratedValue
//    @UuidGenerator
//    @Column(columnDefinition = "UUID")
//    private UUID id;


    @ManyToOne
    @JoinColumn(name = "speciality_id", nullable = false)
    private Speciality speciality;

    @Column(name = "matricule", nullable = false, unique = true)
    private String matricule;

    @Column(name = "titre", nullable = false)
    private String titre;

    @Column(name="tel" ,nullable=true)
    private String tel;

    @Column(name="is_active")
    private boolean is_active;

    public boolean getIs_active() {
        return is_active;
    }

    public void setIs_active(boolean is_active) {
        this.is_active = is_active;
    }

    // Constructeurs
    public Doctor() {}

    public Doctor(UUID id,String email, String password, String fullName, Role role,String matricule, Speciality speciality,String titre,String tel,boolean is_active) {
        super(id,email,fullName,password,Role.DOCTOR);
        this.matricule = matricule;
        this.speciality = speciality;
        this.titre=titre;
        this.tel=tel;
        this.is_active=is_active;
    }

    public Speciality getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Speciality speciality) {
        this.speciality = speciality;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }


    @Override
    public String toString() {
        return "Doctor{" +
                "id=" + id +
                ", speciality=" + speciality +
                ", matricule='" + matricule + '\'' +
                ", titre='" + titre + '\'' +
                ", tel='" + tel + '\'' +
                ", is_active=" + is_active +
                '}';
    }
}
