package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Availibility;

import java.util.List;
import java.util.UUID;

public interface IAvailibilityRepo {
    void save(Availibility availibility);
    Availibility findById(UUID id);
    List<Availibility> findAll();
    void update(Availibility availibility);
    void delete(UUID id);
    List<Availibility> findByDoctorId(UUID doctorId);
}
