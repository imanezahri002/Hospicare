package org.example.demo.mapper;

import org.example.demo.dto.auth.LoginDtoRequest;
import org.example.demo.dto.auth.LoginDtoResponse;
import org.example.demo.entities.User;

public class UserMapper {
    // ✅ Mapper le DTO (LoginDtoRequest) vers une entité (User)
    public static User toEntity(LoginDtoRequest dto) {
        User user = new User();
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        return user;
    }

    // ✅ Mapper l'entité (User) vers un DTO de réponse (LoginDtoResponse)
    public static LoginDtoResponse toDto(User user) {


        LoginDtoResponse dto = new LoginDtoResponse();
        dto.setFullName(user.getFullName());
        dto.setEmail(user.getEmail());
        dto.setRole(user.getRole());
        return dto;
    }
}
