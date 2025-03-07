package com.example.demo.exceptions;

public class PedidoProductoNotFoundException extends RuntimeException {
    public PedidoProductoNotFoundException(String message) {
        super(message);
    }
}
