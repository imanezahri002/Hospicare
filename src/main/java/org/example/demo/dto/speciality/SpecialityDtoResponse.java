package org.example.demo.dto.speciality;

import java.util.UUID;

public class SpecialityDtoResponse {
        private UUID id;
        private String nom;

        public SpecialityDtoResponse() {}

        public SpecialityDtoResponse(UUID id, String nom) {
            this.id = id;
            this.nom = nom;
        }

        // 🧱 Getters & Setters
        public UUID getId() {
            return id;
        }

        public void setId(UUID id) {
            this.id = id;
        }

        public String getNom() {
            return nom;
        }

        public void setName(String nom) {
            this.nom = nom;
        }

}
