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

import com.example.demo.api.request.ProductoCreationRequest;
import com.example.demo.models.Producto;
import com.example.demo.services.ProductoService;

@RestController
@RequestMapping("/api/v1/productos")
@CrossOrigin(origins = "*")
public class ProductoController {
    private final ProductoService productoService;

    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }

    @PostMapping
    public Producto createProducto(@RequestBody ProductoCreationRequest ProductoCreationRequest) {
        return productoService.createProducto(ProductoCreationRequest);
    }

    @PutMapping("/{id}")
    public Producto updateProducto(@PathVariable Long id,
            @RequestBody ProductoCreationRequest productoCreationRequest) {
        return productoService.updateProducto(id, productoCreationRequest);
    }

    @DeleteMapping("/{id}")
    public void deleteProducto(@PathVariable Long id) {
        productoService.removeProducto(id);
    }

    @GetMapping("/{id}")
    public Producto getProducto(@PathVariable Long id) {
        return productoService.getProducto(id).orElse(null);
    }

    @GetMapping("/getall")
    public List<Producto> getAllProductos() {
        return productoService.getAllProductos();
    }

}
