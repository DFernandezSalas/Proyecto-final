package com.example.demo.services;

import org.springframework.stereotype.Service;
import com.example.demo.api.request.UserCreationRequest;
import com.example.demo.models.User;
import com.example.demo.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User createUser(UserCreationRequest userCreationRequest) {
        return userRepository.save(mapToUser(userCreationRequest));
    }

    public User mapToUser(UserCreationRequest createRequest) {
        User user = new User();
        user.setNombre(createRequest.nombre());
        user.setPassword(createRequest.password());
        user.setEdad(createRequest.edad());
        user.setAdministrador(createRequest.administrador());
        user.setLugarNacimiento(createRequest.lugarNacimiento());
        user.setTrato(createRequest.trato());
        user.setImagenPath(createRequest.imagenPath());
        return user;
    }

    public User updateUser(Long id, UserCreationRequest updateRequest) {
        Optional<User> optionalUser = userRepository.findById(id);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setNombre(updateRequest.nombre());
            user.setPassword(updateRequest.password());
            user.setEdad(updateRequest.edad());
            user.setAdministrador(updateRequest.administrador());
            user.setLugarNacimiento(updateRequest.lugarNacimiento());
            user.setTrato(updateRequest.trato());
            user.setImagenPath(updateRequest.imagenPath());
            return userRepository.save(user);
        }
        return null;
    }

    public void removeUser(Long id) {
        userRepository.deleteById(id);

    }

    public Optional<User> getUser(final long id) {
        return userRepository.findById(id);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}
