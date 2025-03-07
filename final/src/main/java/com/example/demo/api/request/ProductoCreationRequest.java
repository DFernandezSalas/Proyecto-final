package com.example.demo.api.request;

import java.util.List;

import com.example.demo.models.PedidoProducto;
// Campos para el JSON
public record ProductoCreationRequest(String nombre, String descripcion, String imagen, int stock, double precio, List<PedidoProducto> pedidos) {
    
}
