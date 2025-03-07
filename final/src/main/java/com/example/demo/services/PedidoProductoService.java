package com.example.demo.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.api.request.PedidoProductoCreationRequest;
import com.example.demo.exceptions.PedidoProductoNotFoundException;
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

    public PedidoProducto createPedidoProducto(PedidoProductoCreationRequest pedidoProductoCreationRequest,
            Pedido pedido, Producto producto) {
        return pedidoProductoRepository.save(mapToPedidoProducto(pedidoProductoCreationRequest, pedido, producto));
    }

    public PedidoProducto mapToPedidoProducto(PedidoProductoCreationRequest createRequest, Pedido pedido,
            Producto producto) {
        PedidoProducto pedidoProducto = new PedidoProducto();
        pedidoProducto.setPedido(pedido);
        pedidoProducto.setProducto(producto);
        pedidoProducto.setCantidad(createRequest.cantidad());
        return pedidoProducto;
    }

    public PedidoProducto updatePedidoProducto(Long id, PedidoProductoCreationRequest updateRequest, Pedido pedido,
            Producto producto) {
        PedidoProducto pedidoProducto = pedidoProductoRepository.findById(id)
                .orElseThrow(() -> new PedidoProductoNotFoundException("❌ PedidoProducto no encontrado con ID: " + id));
        pedidoProducto.setPedido(pedido);
        pedidoProducto.setProducto(producto);
        pedidoProducto.setCantidad(updateRequest.cantidad());
        return pedidoProducto;
    }

    public void removePedidoProducto(Long id) {
        if (!pedidoProductoRepository.existsById(id)) {
            throw new PedidoProductoNotFoundException(
                    "❌ No se puede eliminar. PedidoProducto con ID " + id + " no encontrado.");
        }
        pedidoProductoRepository.deleteById(id);

    }

    public PedidoProducto getPedidoProducto(final long id) {
        return pedidoProductoRepository.findById(id)
                .orElseThrow(() -> new PedidoProductoNotFoundException("❌ PedidoProducto no encontrado con ID: " + id));
    }

    public List<PedidoProducto> getAllPedidoProducto() {
        return pedidoProductoRepository.findAll();
    }
}
