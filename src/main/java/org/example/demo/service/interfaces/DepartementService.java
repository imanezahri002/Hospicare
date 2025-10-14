package org.example.demo.service.interfaces;

import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;

import java.util.List;

public interface DepartementService {
    DepartementDtoResponse addDepartement(DepartementDtoRequest dtoRequest);
    List<DepartementDtoResponse> findAllDepartement();
}
