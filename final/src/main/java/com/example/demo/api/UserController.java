package com.example.demo.api;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.api.request.UserCreationRequest;
import com.example.demo.models.User;
import com.example.demo.services.UserService;

@RestController
@RequestMapping("/api/v1/users")
@CrossOrigin(origins = "*")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService){
        this.userService = userService;
    }

    // Crear un nuevo usuario
    @PostMapping
    public User createUser(@RequestBody UserCreationRequest userCreationRequest){
        return userService.createUser(userCreationRequest);
    }

    // Actualizar un usuario existente
    @PutMapping("/{id}")
    public User updateUser(@PathVariable Long id, @RequestBody UserCreationRequest userCreationRequest) {
        return userService.updateUser(id, userCreationRequest);
    }

    // Eliminar un usuario por su ID
    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Long id){
        userService.removeUser(id);
    }

    // Obtener un usuario por su ID
    @GetMapping("/{id}")
    public User getUser (@PathVariable Long id){
        return userService.getUser(id);
    }

    // Obtener la lista de todos los usuarios
    @GetMapping("/getall")
    public List<User> getAllUsers(){
        return userService.getAllUsers();
    }
}
