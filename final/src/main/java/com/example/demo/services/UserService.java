package com.example.demo.services;

import org.springframework.stereotype.Service;
import com.example.demo.api.request.UserCreationRequest;
import com.example.demo.exceptions.UserNotFoundException;
import com.example.demo.models.User;
import com.example.demo.repository.UserRepository;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User createUser(UserCreationRequest userCreationRequest) {
        return userRepository.save(mapToUser(userCreationRequest));
    }

    //Crear usuario
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

    //Actualizar usuario
    public User updateUser(Long id, UserCreationRequest updateRequest) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("Usuario no encontrado con ID: " + id));

        user.setNombre(updateRequest.nombre());
        user.setPassword(updateRequest.password());
        user.setEdad(updateRequest.edad());
        user.setAdministrador(updateRequest.administrador());
        user.setLugarNacimiento(updateRequest.lugarNacimiento());
        user.setTrato(updateRequest.trato());
        user.setImagenPath(updateRequest.imagenPath());
        user.setBloqueado(updateRequest.bloqueado());
        return userRepository.save(user);
    }

    // Borrar usuario
    public void removeUser(Long id) {
        if (!userRepository.existsById(id)) {
            throw new UserNotFoundException("No se puede eliminar. Usuario con ID " + id + " no encontrado.");
        }
        userRepository.deleteById(id);

    }

    // Obtener id de usuario
    public User getUser(final long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("Usuario no encontrado con ID: " + id));
    }

    // Obtener lista de usuarios
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}
