package org.example.demo.service.interfaces;

import org.example.demo.entities.Speciality;

import java.util.List;
import java.util.UUID;

public interface SpecialityService {

    List<Speciality> getAllSpecialities();
    void addSpeciality(Speciality speciality);
    void deleteSpeciality(UUID id);
    Speciality getSpecialityById(UUID id);
    void updateSpeciality(Speciality speciality);

}
