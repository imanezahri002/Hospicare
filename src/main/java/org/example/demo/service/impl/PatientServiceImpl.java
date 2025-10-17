package org.example.demo.service.impl;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.demo.dto.Patient.PatientDtoRequest;
import org.example.demo.entities.Patient;
import org.example.demo.mapper.PatientMapper;
import org.example.demo.repository.Implement.PatientRepoImpl;
import org.example.demo.repository.Interfaces.IPatientRepo;
import org.example.demo.service.interfaces.PatientService;

import java.util.List;
import java.util.UUID;

@Stateless
public class PatientServiceImpl implements PatientService {
    
    private final IPatientRepo patientRepo = new PatientRepoImpl();


    public void savePatient(PatientDtoRequest dto) {
        Patient patient = PatientMapper.toEntity(dto);
        patientRepo.save(patient);
    }
    @Override
    public Patient findById(UUID id) {
        return patientRepo.findById(id);
    }
    @Override

    public List<Patient> findAll() {
        return patientRepo.findAll();
    }
    @Override

    public void updatePatient(Patient patient) {
        patientRepo.update(patient);
    }
    @Override

    public void deletePatient(UUID id) {
        patientRepo.delete(id);
    }


}