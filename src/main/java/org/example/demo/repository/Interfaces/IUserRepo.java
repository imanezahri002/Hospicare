package org.example.demo.repository.Interfaces;

import org.example.demo.entities.User;

import java.sql.SQLException;

public interface IUserRepo {
    User findByEmailAndPassword(String email,String password) ;
}
