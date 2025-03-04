package com.example.demo.api.request;

public record UserCreationRequest(String nombre, String password, int edad, boolean administrador, String lugarNacimiento, String trato, String imagenPath) {

}
