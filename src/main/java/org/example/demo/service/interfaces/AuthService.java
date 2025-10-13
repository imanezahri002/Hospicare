package org.example.demo.service.interfaces;

import org.example.demo.dto.auth.LoginDtoRequest;
import org.example.demo.dto.auth.LoginDtoResponse;

public interface AuthService {
    LoginDtoResponse login(LoginDtoRequest request);
}
