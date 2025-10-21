package org.example.demo.service.interfaces;

import org.example.demo.entities.Appointement;
import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface AppointementService {

    Map<Doctor,List<LocalTime>> findDoctorAndDispo(String specialityName, LocalDate date);
    void addAppointment(Appointement appointment);
    List<Appointement> findAppointements(UUID idPatient);
}
