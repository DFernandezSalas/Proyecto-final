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

    public User createUser(UserCreationRequest userCreationRequest){
        return userRepository.save(mapToUser(userCreationRequest));
    }

    public User mapToUser(UserCreationRequest createRquest){
        User user = new User();
        user.setNombre(createRquest.nombre());
        user.setPassword(createRquest.password());
        user.setEdad(createRquest.edad());
        user.setAdministrador(createRquest.administrador());
        return user;
    }

    public void removeUser(Long id){
        userRepository.deleteById(id);

    }

    public Optional<User> getUser(final long id){
        return userRepository.findById(id);
    }

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }
}   
