package org.example.demo.dto.auth;

public class LoginDtoRequest {

        private String email;
        private String password;

        // Constructeur vide
        public LoginDtoRequest() {}

        // Constructeur avec paramètres
        public LoginDtoRequest(String email, String password) {
            this.email = email;
            this.password = password;
        }

        // Getters et Setters
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }

}
