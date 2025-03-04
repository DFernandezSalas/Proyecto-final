package com.example.demo.api.request;

public record ProductoCreationRequest(String nombre, String descripcion, String imagen, int stock, double precio) {
    
}
