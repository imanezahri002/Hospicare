package org.example.demo.dto.departement;

import java.util.UUID;

public class DepartementDtoResponse {

        private UUID id;
        private String code;
        private String nom;
        private String description;
        private boolean is_active;

        public DepartementDtoResponse(){};
        public DepartementDtoResponse(UUID id,String code, String nom, String description,boolean is_active) {
            this.id=id;
            this.code = code;
            this.nom = nom;
            this.description = description;
            this.is_active=is_active;
        }

    public boolean getIs_active() {
        return is_active;
    }

    public void setIs_active(boolean is_active) {
        this.is_active = is_active;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
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
