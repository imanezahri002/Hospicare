package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Speciality;

import java.util.List;

public interface ISpecialityRepo {
    List<Speciality> findAll();
}
