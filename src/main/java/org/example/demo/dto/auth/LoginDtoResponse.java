package org.example.demo.dto.auth;

import org.example.demo.entities.enums.Role;

public class LoginDtoResponse {
    private String fullName;
    private String email;
    private Role role;

    // Constructeur vide
    public LoginDtoResponse() {}

    // Constructeur avec paramètres
    public LoginDtoResponse(String fullName,String email, Role role) {
        this.email = email;
        this.fullName=fullName;
        this.role=role;
    }


    public void setEmail(String email) { this.email = email; }
    public void setRole(Role role){this.role=role;}
    public void setFullName(String fullName){this.fullName=fullName;}


}
