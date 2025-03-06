package com.example.demo.api.request;

import java.util.List;

import com.example.demo.models.PedidoProducto;
import com.example.demo.models.User;

public record PedidoCreationRequest(User usuario, List<PedidoProducto> productos, double total, String estado) {

}
