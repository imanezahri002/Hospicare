package org.example.demo.service.interfaces;

import org.example.demo.entities.Patient;

import java.util.List;
import java.util.UUID;

public interface PatientService {

    Patient findById(UUID id);
    List<Patient> findAll();
    void updatePatient(Patient patient);
    void deletePatient(UUID id);
}
