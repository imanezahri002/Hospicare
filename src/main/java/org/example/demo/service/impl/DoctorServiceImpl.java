package org.example.demo.service.impl;

import org.example.demo.entities.Doctor;
import org.example.demo.repository.Implement.DoctorRepoImpl;
import org.example.demo.repository.Interfaces.IDoctorRepo;
import org.example.demo.service.interfaces.DoctorService;

import java.util.List;
import java.util.UUID;

public class DoctorServiceImpl implements DoctorService {

    private final IDoctorRepo doctorRepo = new DoctorRepoImpl();
    @Override
    public void saveDoctor(Doctor doctor) {
        doctorRepo.save(doctor);
    }

    // 🔍 Trouver un docteur par ID
    @Override
    public Doctor findById(UUID id) {
        return doctorRepo.findById(id);
    }

    // 📋 Récupérer tous les docteurs
    @Override
    public List<Doctor> findAll() {
        return doctorRepo.findAll();
    }

    // ✏️ Mettre à jour un docteur
    @Override
    public void updateDoctor(Doctor doctor) {
        doctorRepo.update(doctor);
    }

    // 🗑️ Supprimer un docteur
    @Override
    public void deleteDoctor(UUID id) {
        doctorRepo.delete(id);
    }
}
