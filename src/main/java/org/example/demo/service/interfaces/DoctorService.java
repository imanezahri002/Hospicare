package org.example.demo.service.interfaces;

import org.example.demo.entities.Doctor;

import java.util.List;
import java.util.UUID;

public interface DoctorService {
    void saveDoctor(Doctor doctor);
    Doctor findById(UUID id);
    List<Doctor> findAll();
    void updateDoctor(Doctor doctor);
    void deleteDoctor(UUID id);
}
