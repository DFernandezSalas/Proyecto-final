package com.example.demo.api.request;

// Campos para el JSON
public record UserCreationRequest(String nombre, String password, int edad, boolean administrador, String lugarNacimiento, String trato, String imagenPath, boolean bloqueado) {

}
