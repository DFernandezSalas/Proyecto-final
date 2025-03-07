package com.example.demo.api.request;

import java.util.List;
// Campos para el JSON
public record PedidoCreationRequest(Long usuarioId, List<PedidoProductoCreationRequest> productos, double total, String estado) {

}
