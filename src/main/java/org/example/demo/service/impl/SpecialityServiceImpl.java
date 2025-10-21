package org.example.demo.service.impl;

import org.example.demo.entities.Speciality;
import org.example.demo.repository.Implement.SpecialityRepoImpl;
import org.example.demo.repository.Interfaces.ISpecialityRepo;
import org.example.demo.service.interfaces.SpecialityService;

import java.util.List;
import java.util.UUID;

public class SpecialityServiceImpl implements SpecialityService {
    private final ISpecialityRepo specialityRepository = new SpecialityRepoImpl();

    @Override
    public List<Speciality> getAllSpecialities() {
        return specialityRepository.findAll();
    }

    @Override
    public void addSpeciality(Speciality speciality) {
        specialityRepository.save(speciality);
    }

    @Override
    public void updateSpeciality(Speciality speciality) {
        specialityRepository.update(speciality);
    }

    @Override
    public void deleteSpeciality(UUID id) {
        specialityRepository.delete(id);
    }

    @Override
    public Speciality getSpecialityById(UUID id) {
        return specialityRepository.findById(id);
    }
}
