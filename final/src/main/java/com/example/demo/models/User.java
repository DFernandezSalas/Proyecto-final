package com.example.demo.models;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;

@Entity
@Table(name = "User")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "password")
    private String password;

    @Column(name = "edad")
    private int edad;

    @Column(name = "administrador")
    private boolean administrador;

    @Column(name = "trato")
    private String trato;

    @Column(name = "lugar_nacimiento")
    private String lugarNacimiento;

    @Column(name = "imagen_path")
    private String imagenPath;

    @Column(name = "bloqueado")
    private boolean bloqueado;

    // Relación con Pedido
    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<Pedido> pedidos = new ArrayList<>();

    // Constructor vacío requerido por JPA
    public User() {
    }

    // Constructor con todos los atributos
    public User(String nombre, String password, int edad, boolean administrador,
            String trato, String lugarNacimiento, String imagenPath, boolean bloqueado) {
        this.nombre = nombre;
        this.password = password;
        this.edad = edad;
        this.administrador = administrador;
        this.trato = trato;
        this.lugarNacimiento = lugarNacimiento;
        this.imagenPath = imagenPath;
        this.bloqueado = bloqueado;
    }

    // Getters y Setters
    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public boolean isAdministrador() {
        return administrador;
    }

    public void setAdministrador(boolean administrador) {
        this.administrador = administrador;
    }

    public String getTrato() {
        return trato;
    }

    public void setTrato(String trato) {
        this.trato = trato;
    }

    public String getLugarNacimiento() {
        return lugarNacimiento;
    }

    public void setLugarNacimiento(String lugarNacimiento) {
        this.lugarNacimiento = lugarNacimiento;
    }

    public String getImagenPath() {
        return imagenPath;
    }

    public void setImagenPath(String imagenPath) {
        this.imagenPath = imagenPath;
    }

    public boolean isBloqueado() {
        return bloqueado;
    }

    public void setBloqueado(boolean bloqueado) {
        this.bloqueado = bloqueado;
    }

    public List<Pedido> getPedidos() {
        return pedidos;
    }

    public void setPedidos(List<Pedido> pedidos) {
        this.pedidos = pedidos;
    }

    @Override
    public int hashCode() {
        return Objects.hash(Id);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null || getClass() != obj.getClass())
            return false;
        User other = (User) obj;
        return Objects.equals(Id, other.Id);
    }

}
