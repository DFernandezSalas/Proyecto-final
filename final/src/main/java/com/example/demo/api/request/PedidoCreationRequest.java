package com.example.demo.api.request;

import java.util.List;

import com.example.demo.models.PedidoProducto;
public record PedidoCreationRequest(Long usuarioId, List<PedidoProducto> productos, double total, String estado) {

}
