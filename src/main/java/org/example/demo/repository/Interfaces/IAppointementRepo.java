package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

public interface IAppointementRepo {

    Map<Doctor, List<LocalTime>> findDoctorAndDispoBySpecialityDate(String specialityName, LocalDate date);
}
