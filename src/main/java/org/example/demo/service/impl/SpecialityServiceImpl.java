package org.example.demo.service.impl;

import org.example.demo.entities.Speciality;
import org.example.demo.repository.Implement.SpecialityRepoImpl;
import org.example.demo.repository.Interfaces.ISpecialityRepo;

import java.util.List;
import java.util.UUID;

public class SpecialityServiceImpl {
    private final ISpecialityRepo specialityRepository = new SpecialityRepoImpl();

    public List<Speciality> getAllSpecialities() {
        return specialityRepository.findAll();
    }

    public void addSpeciality(Speciality speciality) {
        specialityRepository.save(speciality);
    }

    public void updateSpeciality(Speciality speciality) {
        specialityRepository.update(speciality);
    }

    public void deleteSpeciality(UUID id) {
        specialityRepository.delete(id);
    }

    public Speciality getSpecialityById(UUID id) {
        return specialityRepository.findById(id);
    }
}
