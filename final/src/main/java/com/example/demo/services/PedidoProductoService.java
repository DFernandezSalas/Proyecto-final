package com.example.demo.services;

import org.springframework.stereotype.Service;

import com.example.demo.api.request.PedidoProductoCreationRequest;
import com.example.demo.api.request.UserCreationRequest;
import com.example.demo.models.PedidoProducto;
import com.example.demo.models.User;
import com.example.demo.repository.PedidoProductoRepository;

@Service
public class PedidoProductoService {
    private final PedidoProductoRepository pedidoProductoRepository;

    public PedidoProductoService(PedidoProductoRepository pedidoProductoRepository) {
        this.pedidoProductoRepository = pedidoProductoRepository;
    }

    public PedidoProducto createPedidoProducto(PedidoProductoCreationRequest PedidoProductoCreationRequest) {
        return pedidoProductoRepository.save(mapToPedidoProducto(PedidoProductoCreationRequest));
    }

    public PedidoProducto mapToPedidoProducto(PedidoProductoCreationRequest createRequest) {
        PedidoProducto pedidoProducto = new PedidoProducto();
        pedidoProducto.setPedido(createRequest.pedido());
        pedidoProducto.setProducto(createRequest.producto());
        pedidoProducto.setCantidad(createRequest.cantidad());
        return pedidoProducto;
    }
}
