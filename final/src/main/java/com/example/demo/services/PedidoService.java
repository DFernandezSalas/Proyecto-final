package com.example.demo.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.api.request.PedidoCreationRequest;
import com.example.demo.api.request.PedidoProductoCreationRequest;
import com.example.demo.models.Pedido;
import com.example.demo.models.PedidoProducto;
import com.example.demo.models.User;
import com.example.demo.repository.PedidoRepository;
import com.example.demo.repository.ProductoRepository;

@Service
public class PedidoService {
    private final PedidoRepository pedidoRepository;
    private final ProductoRepository productoRepository;
    // private final PedidoProductoRepository pedidoProductoRepository;

    /*
     * public PedidoService(PedidoRepository pedidoRepository) {
     * this.pedidoRepository = pedidoRepository;
     * }
     */
    @Autowired
    public PedidoService(
            PedidoRepository pedidoRepository,
            ProductoRepository productoRepository) {
        this.pedidoRepository = pedidoRepository;
        this.productoRepository = productoRepository;
    }

    public Pedido createPedido(PedidoCreationRequest pedidoCreationRequest, User user) {
        return pedidoRepository.save(mapToPedido(pedidoCreationRequest, user));
    }

    public Pedido mapToPedido(PedidoCreationRequest createRequest, User user) {
        Pedido pedido = new Pedido();
        pedido.setUsuario(user);
        pedido = pedidoRepository.save(pedido);
        List<PedidoProducto> products = getProducts(createRequest, pedido);
        pedido.setProductos(products);
        pedido.setTotal(createRequest.total());
        pedido.setEstado(createRequest.estado());
        return pedido;
    }

    public Pedido updatePedido(Long id, PedidoCreationRequest updateRequest, User user) {
        Optional<Pedido> optionalPedido = pedidoRepository.findById(id);
        if (optionalPedido.isPresent()) {
            Pedido pedido = optionalPedido.get();
            pedido.setUsuario(user);
            List<PedidoProducto> products = getProducts(updateRequest, pedido);
            pedido.setProductos(products);
            pedido.setTotal(updateRequest.total());
            pedido.setEstado(updateRequest.estado());
            return pedidoRepository.save(pedido);
        }
        return null;
    }

    public void removePedido(Long id) {
        pedidoRepository.deleteById(id);

    }

    public Optional<Pedido> getPedido(final long id) {
        return pedidoRepository.findById(id);
    }

    public List<Pedido> getAllPedidos() {
        return pedidoRepository.findAll();
    }

    private List<PedidoProducto> getProducts(PedidoCreationRequest createRequest, Pedido pedido) {
        List<PedidoProducto> products = new ArrayList<>();
        for (PedidoProductoCreationRequest item : createRequest.productos()) {
            PedidoProducto pp = new PedidoProducto();
            pp.setPedido(pedido);
            pp.setProducto(productoRepository.findById(item.producto()).orElse(null));
            pp.setCantidad(item.cantidad());
            products.add(pp);
        }
        return products;
    }
}
