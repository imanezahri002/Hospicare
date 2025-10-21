package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Appointement;
import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface IAppointementRepo {

    Map<Doctor, List<LocalTime>> findDoctorAndDispoBySpecialityDate(String specialityName, LocalDate date);

    void save(Appointement appointment);

    List<Appointement> findByPatientId(UUID patientId);
}
