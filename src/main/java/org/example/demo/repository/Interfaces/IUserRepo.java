package org.example.demo.repository.Interfaces;

import org.example.demo.entities.User;

import java.sql.SQLException;
import java.util.List;

public interface IUserRepo {
    User findByEmailAndPassword(String email,String password) ;
    List<User> findAll();
}
