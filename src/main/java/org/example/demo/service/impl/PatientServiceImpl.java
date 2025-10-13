package org.example.demo.service.impl;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.demo.dto.Patient.PatientDtoRequest;
import org.example.demo.entities.Patient;
import org.example.demo.mapper.PatientMapper;

@Stateless
public class PatientServiceImpl {

    @PersistenceContext(unitName = "default")  // ton persistence-unit dans persistence.xml
    private EntityManager em;

    public void savePatient(PatientDtoRequest dto) {
        Patient patient = PatientMapper.toEntity(dto);
        em.persist(patient);
    }
}