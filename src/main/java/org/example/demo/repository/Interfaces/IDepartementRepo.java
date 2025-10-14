package org.example.demo.repository.Interfaces;

import org.example.demo.entities.Departement;

import java.util.List;
import java.util.UUID;

public interface IDepartementRepo {
    void save(Departement department);
    List<Departement> allDepartements();
    void update(Departement departement);
    Departement findById(UUID id);
    void delete(UUID id);
}
