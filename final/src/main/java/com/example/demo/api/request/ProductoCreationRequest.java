package com.example.demo.api.request;

import java.util.List;

import com.example.demo.models.PedidoProducto;

public record ProductoCreationRequest(String nombre, String descripcion, String imagen, int stock, double precio, List<PedidoProducto> pedidos) {
    
}
