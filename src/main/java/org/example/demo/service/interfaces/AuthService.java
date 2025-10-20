package org.example.demo.service.interfaces;

import org.example.demo.dto.auth.LoginDtoRequest;
import org.example.demo.dto.auth.LoginDtoResponse;
import org.example.demo.entities.User;

public interface AuthService {
    User login(LoginDtoRequest request);
}
