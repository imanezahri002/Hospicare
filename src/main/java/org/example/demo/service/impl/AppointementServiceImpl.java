package org.example.demo.service.impl;

import org.example.demo.entities.Availibility;
import org.example.demo.entities.Doctor;
import org.example.demo.repository.Implement.AppointementRepoImpl;
import org.example.demo.repository.Interfaces.IAppointementRepo;
import org.example.demo.service.interfaces.AppointementService;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

public class AppointementServiceImpl implements AppointementService {

    private final IAppointementRepo apointementRepo=new AppointementRepoImpl();

    @Override
    public Map<Doctor, List<LocalTime>>findDoctorAndDispo(String specialityName, LocalDate date){
        return apointementRepo.findDoctorAndDispoBySpecialityDate(specialityName,date);
    }

}
