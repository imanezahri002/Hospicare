package org.example.demo.service.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.entities.Departement;
import org.example.demo.mapper.DepartementMapper;
import org.example.demo.repository.Implement.DepartementRepoImpl;
import org.example.demo.repository.Interfaces.IDepartementRepo;
import org.example.demo.service.interfaces.DepartementService;

import java.util.List;
import java.util.stream.Collectors;

public class DepartementServiceImpl implements DepartementService {

    private IDepartementRepo departmentRepository = new DepartementRepoImpl();

    @Override
    public DepartementDtoResponse addDepartement(DepartementDtoRequest dtoRequest) {
        Departement departement = DepartementMapper.toEntity(dtoRequest);
        departmentRepository.save(departement);
        return DepartementMapper.toDto(departement);
    }
    @Override
    public List<DepartementDtoResponse>findAllDepartement(){

        List<Departement> departements=departmentRepository.allDepartements();
        System.out.println(departements);
        return departements.stream().map(DepartementMapper::toDto).collect(Collectors.toList());
    }

}
