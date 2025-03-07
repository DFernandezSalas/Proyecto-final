package com.example.demo.services;

import org.springframework.stereotype.Service;
import com.example.demo.api.request.ProductoCreationRequest;
import com.example.demo.exceptions.ProductoNotFoundException;
import com.example.demo.models.Producto;
import com.example.demo.repository.ProductoRepository;

import java.util.List;

@Service
public class ProductoService {

    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public Producto createProducto(ProductoCreationRequest productoCreationRequest) {
        return productoRepository.save(mapToProducto(productoCreationRequest));
    }

    // Crear producto
    public Producto mapToProducto(ProductoCreationRequest createRequest) {
        Producto producto = new Producto();
        producto.setNombre(createRequest.nombre());
        producto.setDescripcion(createRequest.descripcion());
        producto.setImagen(createRequest.imagen());
        producto.setStock(createRequest.stock());
        producto.setPrecio(createRequest.precio());
        producto.setPedidos(createRequest.pedidos());
        return producto;
    }

    // Actualizar producto
    public Producto updateProducto(Long id, ProductoCreationRequest updateRequest) {
        Producto producto = productoRepository.findById(id)
                .orElseThrow(() -> new ProductoNotFoundException("❌ Producto no encontrado con ID: " + id));
        producto.setNombre(updateRequest.nombre());
        producto.setDescripcion(updateRequest.descripcion());
        producto.setImagen(updateRequest.imagen());
        producto.setStock(updateRequest.stock());
        producto.setPrecio(updateRequest.precio());
        producto.setPedidos(updateRequest.pedidos());
        return productoRepository.save(producto);
    }

    // Borrar producto
    public void removeProducto(Long id) {
        if (!productoRepository.existsById(id)) {
            throw new ProductoNotFoundException("❌ No se puede eliminar. Producto con ID " + id + " no encontrado.");
        }
        productoRepository.deleteById(id);

    }

    // Obtener id producto
    public Producto getProducto(final long id) {
        return productoRepository.findById(id)
                .orElseThrow(() -> new ProductoNotFoundException("❌ Producto no encontrado con ID: " + id));
    }

    // Obtener lista de productos
    public List<Producto> getAllProductos() {
        return productoRepository.findAll();
    }

}
