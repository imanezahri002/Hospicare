package org.example.demo.mapper;

import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.entities.Departement;

public class DepartementMapper {
    // 🔹 Mapper du DTO vers l'entité
    public static Departement toEntity(DepartementDtoRequest dto) {
        Departement departement = new Departement();
        departement.setCode(dto.getCode());
        departement.setNom(dto.getNom());
        departement.setDescription(dto.getDescription());
        return departement;
    }
    // 🔹 (Optionnel) Mapper de l'entité vers un DTO si tu veux afficher après ajout
    public static DepartementDtoResponse toDto(Departement entity) {
        return new DepartementDtoResponse(
                entity.getId(),
                entity.getCode(),
                entity.getNom(),
                entity.getDescription()
        );
    }
}
