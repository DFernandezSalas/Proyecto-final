package com.example.demo.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.demo.api.request.PedidoProductoCreationRequest;
import com.example.demo.models.Pedido;
import com.example.demo.models.PedidoProducto;
import com.example.demo.models.Producto;
import com.example.demo.repository.PedidoProductoRepository;

@Service
public class PedidoProductoService {
    private final PedidoProductoRepository pedidoProductoRepository;

    public PedidoProductoService(PedidoProductoRepository pedidoProductoRepository) {
        this.pedidoProductoRepository = pedidoProductoRepository;
    }

    public PedidoProducto createPedidoProducto(PedidoProductoCreationRequest pedidoProductoCreationRequest, Pedido pedido, Producto producto) {
        return pedidoProductoRepository.save(mapToPedidoProducto(pedidoProductoCreationRequest, pedido, producto));
    }

    public PedidoProducto mapToPedidoProducto(PedidoProductoCreationRequest createRequest, Pedido pedido, Producto producto) {
        PedidoProducto pedidoProducto = new PedidoProducto();
        pedidoProducto.setPedido(pedido);
        pedidoProducto.setProducto(producto);
        pedidoProducto.setCantidad(createRequest.cantidad());
        return pedidoProducto;
    }

    public PedidoProducto updatePedidoProducto(Long id, PedidoProductoCreationRequest updateRequest, Pedido pedido, Producto producto) {
        Optional<PedidoProducto> optionalPedidoProducto = pedidoProductoRepository.findById(id);
        if (optionalPedidoProducto.isPresent()) {
            PedidoProducto pedidoProducto = optionalPedidoProducto.get();
            pedidoProducto.setPedido(pedido);
            pedidoProducto.setProducto(producto);
            pedidoProducto.setCantidad(updateRequest.cantidad());
            return pedidoProducto;
        }
        return null;
    }

    public void removePedidoProducto(Long id) {
        pedidoProductoRepository.deleteById(id);

    }

    public Optional<PedidoProducto> getPedidoProducto(final long id) {
        return pedidoProductoRepository.findById(id);
    }

    public List<PedidoProducto> getAllPedidoProducto() {
        return pedidoProductoRepository.findAll();
    }
}
