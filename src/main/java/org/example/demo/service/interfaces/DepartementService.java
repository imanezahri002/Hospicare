package org.example.demo.service.interfaces;

import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;

public interface DepartementService {
    DepartementDtoResponse addDepartement(DepartementDtoRequest dtoRequest);
}
