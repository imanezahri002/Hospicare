package org.example.demo.mapper;

import org.example.demo.dto.speciality.SpecialityDtoResponse;
import org.example.demo.entities.Speciality;

public class SpecialityMapper {

    // 🔁 Entity → Response DTO
    public static SpecialityDtoResponse toResponseDTO(Speciality entity) {
        if (entity == null) return null;
        return new SpecialityDtoResponse(entity.getId(), entity.getNom());
    }
}
