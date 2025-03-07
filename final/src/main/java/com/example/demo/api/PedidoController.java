package com.example.demo.api;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.api.request.PedidoCreationRequest;
import com.example.demo.models.Pedido;
import com.example.demo.models.User;
import com.example.demo.services.PedidoService;
import com.example.demo.services.UserService;

@RestController
@RequestMapping("/api/v1/pedidos")
@CrossOrigin(origins = "*")
public class PedidoController {
    private final PedidoService pedidoService;
    private final UserService userService;

    public PedidoController(PedidoService pedidoService, UserService userService) {
        this.pedidoService = pedidoService;
        this.userService = userService;
    }

    @PostMapping
    public Pedido createPedido(@RequestBody PedidoCreationRequest pedidoCreationRequest) {
        User user = userService.getUser(pedidoCreationRequest.usuarioId()).orElse(null);
        return pedidoService.createPedido(pedidoCreationRequest, user);
    }

    @PutMapping("/{id}")
    public Pedido updatePedido(@PathVariable Long id, @RequestBody PedidoCreationRequest pedidoCreationRequest) {
        User user = userService.getUser(pedidoCreationRequest.usuarioId()).orElse(null);
        return pedidoService.updatePedido(id, pedidoCreationRequest, user);
    }

    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Long id) {
        pedidoService.removePedido(id);
    }

    @GetMapping("/{id}")
    public Pedido getPedido(@PathVariable Long id) {
        return pedidoService.getPedido(id).orElse(null);
    }

    @GetMapping("/getall")
    public List<Pedido> getAllPedidos() {
        return pedidoService.getAllPedidos();
    }
}
