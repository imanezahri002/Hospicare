package org.example.demo.service.impl;

import org.example.demo.entities.Availibility;
import org.example.demo.repository.Implement.AvailibilityRepoImpl;
import org.example.demo.repository.Interfaces.IAvailibilityRepo;
import org.example.demo.service.interfaces.AvailibilityService;

import java.util.List;
import java.util.UUID;

public class AvailibilityServiceImpl implements AvailibilityService {
    private final IAvailibilityRepo availibilityRepo;

    public AvailibilityServiceImpl() {
        this.availibilityRepo = new AvailibilityRepoImpl();
    }

    @Override
    public void save(Availibility availibility) {
        availibilityRepo.save(availibility);
    }

    @Override
    public Availibility findById(UUID id) {
        return availibilityRepo.findById(id);
    }

    @Override
    public List<Availibility> findAll() {
        return availibilityRepo.findAll();
    }
    @Override
    public List<Availibility> findAvailibilityByDoctor(UUID id){
        return availibilityRepo.findByDoctorId(id);
    }

    @Override
    public void update(Availibility availibility) {
        availibilityRepo.update(availibility);
    }

    @Override
    public void delete(UUID id) {
        availibilityRepo.delete(id);
    }
}
