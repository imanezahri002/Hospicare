package org.example.demo.service.impl;

import org.example.demo.dto.auth.LoginDtoRequest;
import org.example.demo.dto.auth.LoginDtoResponse;
import org.example.demo.entities.User;
import org.example.demo.entities.enums.Role;
import org.example.demo.mapper.UserMapper;
import org.example.demo.repository.Interfaces.IUserRepo;
import org.example.demo.service.interfaces.AuthService;

import java.util.regex.Pattern;

public class AuthServiceImp implements AuthService {

    private final IUserRepo userRepository;

    public AuthServiceImp(IUserRepo userRepository){
        this.userRepository=userRepository;
    }

    public LoginDtoResponse login(LoginDtoRequest request) {
        String email = request.getEmail();
        String password = request.getPassword();

        // ✅ 1. Validation email (format)
        if (email == null || !isValidEmail(email)) {
            throw new IllegalArgumentException("Email invalide !");
        }

        // ✅ 2. Validation mot de passe (longueur >= 8)
        if (password == null || password.length() < 8) {
            throw new IllegalArgumentException("Le mot de passe doit contenir au moins 8 caractères !");
        }

        User user = userRepository.findByEmailAndPassword(email, password);
        if (user == null)
            throw new IllegalArgumentException("Email ou mot de passe incorrect !");

        return UserMapper.toDto(user);

    }
    private boolean isValidEmail(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return Pattern.matches(regex, email);
    }
}
