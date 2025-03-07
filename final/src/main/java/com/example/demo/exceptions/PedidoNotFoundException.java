package com.example.demo.exceptions;

public class PedidoNotFoundException extends RuntimeException {
    public PedidoNotFoundException(String message) {
        super(message);
    }
}
