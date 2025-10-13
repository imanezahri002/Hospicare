package org.example.demo.mapper;

import org.example.demo.dto.Patient.PatientDtoRequest;
import org.example.demo.entities.Patient;
import org.example.demo.entities.enums.GroupSanguin;
import org.example.demo.entities.enums.Role;
import org.example.demo.entities.enums.Sexe;

public class PatientMapper {

    public static Patient toEntity(PatientDtoRequest dto) {
        Patient patient = new Patient();
        patient.setFullName(dto.getFullName());
        patient.setEmail(dto.getEmail());
        patient.setPassword(dto.getPassword());
        patient.setCin(dto.getCin());
        patient.setBithdate(dto.getBirthDate());
        patient.setAdresse(dto.getAddress());
        patient.setTelephone(dto.getTelephone());
        patient.setRole(Role.PATIENT);


        // 🩸 Mapper le groupe sanguin (String → Enum)
        if (dto.getSang() != null && !dto.getSang().isEmpty()) {
            switch (dto.getSang()) {
                case "A_POSITIF" -> patient.setSang(GroupSanguin.A_POSITIF);
                case "A_NEGATIF" -> patient.setSang(GroupSanguin.A_NEGATIF);
                case "B_POSITIF" -> patient.setSang(GroupSanguin.B_POSITIF);
                case "B_NEGATIF" -> patient.setSang(GroupSanguin.B_NEGATIF);
                case "AB_POSITIF" -> patient.setSang(GroupSanguin.AB_POSITIF);
                case "AB_NEGATIF" -> patient.setSang(GroupSanguin.AB_NEGATIF);
                case "O_POSITIF" -> patient.setSang(GroupSanguin.O_POSITIF);
                case "O_NEGATIF" -> patient.setSang(GroupSanguin.O_NEGATIF);
                default -> patient.setSang(null);
            }
        }
        // 🚻 Mapper le sexe (String → Enum)
        if (dto.getSexe() != null && !dto.getSexe().isEmpty()) {
            switch (dto.getSexe()) {
                case "MASCULIN" -> patient.setSexe(Sexe.MASCULIN);
                case "FEMININ" -> patient.setSexe(Sexe.FEMININ);
                default -> patient.setSexe(null);
            }
        }

        return patient;
    }
}
