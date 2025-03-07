package com.example.demo.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.api.request.PedidoCreationRequest;
import com.example.demo.api.request.PedidoProductoCreationRequest;
import com.example.demo.exceptions.PedidoNotFoundException;
import com.example.demo.models.Pedido;
import com.example.demo.models.PedidoProducto;
import com.example.demo.models.User;
import com.example.demo.repository.PedidoRepository;
import com.example.demo.repository.ProductoRepository;

@Service
public class PedidoService {
    private final PedidoRepository pedidoRepository;
    private final ProductoRepository productoRepository;

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

    // Crear Pedido
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

    // Actualizar usuario
    public Pedido updatePedido(Long id, PedidoCreationRequest updateRequest, User user) {
        Pedido pedido = pedidoRepository.findById(id)
                .orElseThrow(() -> new PedidoNotFoundException("❌ Pedido no encontrado con ID: " + id));
            pedido.setUsuario(user);
            List<PedidoProducto> products = getProducts(updateRequest, pedido);
            pedido.setProductos(products);
            pedido.setTotal(updateRequest.total());
            pedido.setEstado(updateRequest.estado());
            return pedidoRepository.save(pedido);
    }

    //Borrar pedido
    public void removePedido(Long id) {
        if (!pedidoRepository.existsById(id)) {
            throw new PedidoNotFoundException("❌ No se puede eliminar. Pedido con ID " + id + " no encontrado.");
        }
        pedidoRepository.deleteById(id);

    }

    // Obtener id de pedido
    public Pedido getPedido(final long id) {
         return pedidoRepository.findById(id)
                .orElseThrow(() -> new PedidoNotFoundException("❌ Pedido no encontrado con ID: " + id));
    }

    // Obetener lista de pedidos
    public List<Pedido> getAllPedidos() {
        return pedidoRepository.findAll();
    }

    // Metodo para agregar los productos a la lista y crear el JSON para los productos del pedido
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
