package org.example.demo.service.interfaces;

import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;

import java.util.List;
import java.util.UUID;

public interface DepartementService {
    DepartementDtoResponse addDepartement(DepartementDtoRequest dtoRequest);
    List<DepartementDtoResponse> findAllDepartement();
    DepartementDtoResponse updateDepartement(DepartementDtoRequest dtoRequest);
    DepartementDtoResponse findById(DepartementDtoRequest dtoRequest);
    void delete(UUID id);
}
