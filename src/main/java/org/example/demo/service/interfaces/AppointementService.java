package org.example.demo.service.interfaces;

import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

public interface AppointementService {

    Map<Doctor,List<LocalTime>> findDoctorAndDispo(String specialityName, LocalDate date);

}
