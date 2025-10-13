package org.example.demo.dto.Patient;
import java.time.LocalDate;

public class PatientDtoRequest {

        private String fullName;
        private String email;
        private String password;
        private String cin;
        private LocalDate birthDate;
        private String sang;
        private String sexe;
        private String address;
        private String telephone;
        private String role;

        // Getters et Setters
        public String getFullName() { return fullName; }
        public void setFullName(String fullName) { this.fullName = fullName; }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }

        public String getCin() { return cin; }
        public void setCin(String cin) { this.cin = cin; }

        public LocalDate getBirthDate() { return birthDate; }
        public void setBirthDate(LocalDate birthDate) { this.birthDate = birthDate; }

        public String getSang() { return sang; }
        public void setSang(String sang) { this.sang = sang; }

        public String getSexe() { return sexe; }
        public void setSexe(String sexe) { this.sexe = sexe; }

        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }

        public String getTelephone() { return telephone; }
        public void setTelephone(String telephone) { this.telephone = telephone; }
}
