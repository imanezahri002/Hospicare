package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Departement;

import java.util.List;

public interface IDepartementRepo {
    void save(Departement department);
    List<Departement> allDepartements();
}
