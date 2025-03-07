package com.example.demo.api.request;
// Campos para el JSON
public record PedidoProductoCreationRequest(Long pedido, Long producto, int cantidad) {

}
