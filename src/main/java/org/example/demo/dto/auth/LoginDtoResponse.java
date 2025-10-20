package org.example.demo.dto.auth;

import org.example.demo.entities.enums.Role;

import java.util.UUID;

public class LoginDtoResponse {
    private UUID id;
    private String fullName;
    private String email;
    private Role role;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    // Constructeur vide
    public LoginDtoResponse() {}

    // Constructeur avec paramètres
    public LoginDtoResponse(String fullName,String email, Role role) {
        this.email = email;
        this.fullName=fullName;
        this.role=role;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public Role getRole() {
        return role;
    }

    public void setEmail(String email) { this.email = email; }
    public void setRole(Role role){this.role=role;}
    public void setFullName(String fullName){this.fullName=fullName;}

    public LoginDtoResponse(UUID id, String fullName, String email, Role role) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.role = role;
    }
}
