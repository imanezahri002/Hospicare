package org.example.demo.dto.departement;

public class DepartementDtoRequest {

    private String code;
    private String nom;
    private String description;

    public DepartementDtoRequest(){};

    public DepartementDtoRequest(String code, String nom, String description) {
        this.code = code;
        this.nom = nom;
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
