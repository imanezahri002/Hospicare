package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Speciality;

import java.util.List;
import java.util.UUID;

public interface ISpecialityRepo {
    void save(Speciality speciality);
    void update(Speciality speciality);
    void delete(UUID id);
    Speciality findById(UUID id);
    List<Speciality> findAll();
}
