package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Doctor;

import java.util.List;
import java.util.UUID;

public interface IDoctorRepo {
    void save(Doctor doctor);
    Doctor findById(UUID id);
    List<Doctor> findAll();
    void update(Doctor doctor);
    void delete(UUID id);

}
