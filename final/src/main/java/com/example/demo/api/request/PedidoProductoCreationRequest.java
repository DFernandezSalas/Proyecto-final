package com.example.demo.api.request;

import com.example.demo.models.Pedido;
import com.example.demo.models.Producto;

public record PedidoProductoCreationRequest(Pedido pedido, Producto producto, int cantidad) {

}
