package org.example.demo.dto.departement;

import java.util.UUID;

public class DepartementDtoResponse {

        private UUID id;
        private String code;
        private String nom;
        private String description;

        public DepartementDtoResponse(){};
        public DepartementDtoResponse(UUID id,String code, String nom, String description) {
            this.id=id;
            this.code = code;
            this.nom = nom;
            this.description = description;
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
