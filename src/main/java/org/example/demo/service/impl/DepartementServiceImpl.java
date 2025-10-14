package org.example.demo.service.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.PersistenceContext;
import org.example.demo.config.PersistenceManager;
import org.example.demo.dto.departement.DepartementDtoRequest;
import org.example.demo.dto.departement.DepartementDtoResponse;
import org.example.demo.entities.Departement;
import org.example.demo.mapper.DepartementMapper;
import org.example.demo.repository.Implement.DepartementRepoImpl;
import org.example.demo.repository.Interfaces.IDepartementRepo;
import org.example.demo.service.interfaces.DepartementService;

import java.util.List;
import java.util.UUID;
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

        return departements.stream().map(DepartementMapper::toDto).collect(Collectors.toList());
    }
    @Override
    public DepartementDtoResponse updateDepartement(DepartementDtoRequest dtoRequest){
        Departement existing = departmentRepository.findById(dtoRequest.getId());

        if (existing == null) {
            throw new RuntimeException("Aucun département trouvé avec l'ID : " + dtoRequest.getId());
        }

        existing.setNom(dtoRequest.getNom());
        existing.setCode(dtoRequest.getCode());
        existing.setDescription(dtoRequest.getDescription());
        existing.setActive(dtoRequest.getIs_active());
        existing.setUpdatedAt(java.time.LocalDateTime.now());

        departmentRepository.update(existing);

        return DepartementMapper.toDto(existing);
    }
    @Override
    public DepartementDtoResponse findById(DepartementDtoRequest dtoRequest){
        Departement departement=DepartementMapper.toEntity(dtoRequest);
        departmentRepository.findById(dtoRequest.getId());
        return DepartementMapper.toDto(departement);
    }
    @Override
    public void delete(UUID id) {
        EntityManager em = PersistenceManager.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();

            // ✅ Récupérer l'entité attachée
            Departement departement = em.find(Departement.class, id);
            if (departement != null) {
                em.remove(departement); // supprimer l'entité attachée
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }



}
