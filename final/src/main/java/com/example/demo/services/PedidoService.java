package com.example.demo.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.demo.api.request.PedidoCreationRequest;
import com.example.demo.models.Pedido;
import com.example.demo.models.User;
import com.example.demo.repository.PedidoRepository;

@Service
public class PedidoService {
    private final PedidoRepository pedidoRepository;

    public PedidoService(PedidoRepository pedidoRepository) {
        this.pedidoRepository = pedidoRepository;
    }

    public Pedido createPedido(PedidoCreationRequest pedidoCreationRequest, User user) {
        return pedidoRepository.save(mapToPedido(pedidoCreationRequest, user));
    }

    public Pedido mapToPedido(PedidoCreationRequest createRequest, User user) {
        Pedido pedido = new Pedido();
        pedido.setUsuario(user);
        pedido.setProductos(createRequest.productos());
        pedido.setTotal(createRequest.total());
        pedido.setEstado(createRequest.estado());
        return pedido;
    }

    public Pedido updatePedido(Long id, PedidoCreationRequest updateRequest, User user) {
        Optional<Pedido> optionalPedido = pedidoRepository.findById(id);
        if (optionalPedido.isPresent()) {
            Pedido pedido = optionalPedido.get();
            pedido.setUsuario(user);
            pedido.setProductos(updateRequest.productos());
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
}
