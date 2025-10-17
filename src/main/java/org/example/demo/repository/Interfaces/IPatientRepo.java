package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Patient;

import java.util.List;
import java.util.UUID;

public interface IPatientRepo {
    void save(Patient patient);
    Patient findById(UUID id);
    List<Patient> findAll();
    void update(Patient patient);
    void delete(UUID id);
}
