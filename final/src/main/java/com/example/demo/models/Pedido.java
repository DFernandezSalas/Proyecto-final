package com.example.demo.models;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "Pedido")
public class Pedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    // Relación con User (Muchos pedidos pueden pertenecer a un solo usuario)
    @ManyToOne
    @JoinColumn(name = "usuario_id")
    // @JsonIgnore
    private User usuario;

    @OneToMany(mappedBy = "pedido", cascade = CascadeType.ALL)
    // @JsonIgnore
    private List<PedidoProducto> productos = new ArrayList<>();

    @Column(name = "total")
    private double total;

    @Column(name = "cantidad")
    private String estado;

    public Pedido() {
    }

    public Pedido(User usuario, List<PedidoProducto> productos, double total, String estado) {
        this.usuario = usuario;
        this.productos = productos;
        this.total = total;
        this.estado = estado;
    }

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
    }

    public User getUsuario() {
        return usuario;
    }

    public void setUsuario(User usuario) {
        this.usuario = usuario;
    }

    public List<PedidoProducto> getProductos() {
        return productos;
    }

    public void setProductos(List<PedidoProducto> productos) {
        this.productos = productos;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    @Override
    public boolean equals(Object obj) {
        // TODO Auto-generated method stub
        return super.equals(obj);
    }

    @Override
    public int hashCode() {
        // TODO Auto-generated method stub
        return super.hashCode();
    }

}
