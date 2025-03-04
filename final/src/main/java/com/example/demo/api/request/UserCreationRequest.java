package com.example.demo.api.request;

public record UserCreationRequest(String nombre, String password, int edad, boolean administrador) {

}
