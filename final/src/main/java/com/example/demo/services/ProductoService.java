package com.example.demo.services;

import org.springframework.stereotype.Service;
import com.example.demo.api.request.ProductoCreationRequest;
import com.example.demo.models.Producto;
import com.example.demo.repository.ProductoRepository;

import java.util.List;
import java.util.Optional;



@Service
public class ProductoService {

    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public Producto createProducto(ProductoCreationRequest productoCreationRequest) {
        return productoRepository.save(mapToProducto(productoCreationRequest));
    }

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

    public Producto updateProducto(Long id, ProductoCreationRequest updateRequest) {
        Optional<Producto> optionalProducto = productoRepository.findById(id);
        if (optionalProducto.isPresent()) {
            Producto producto = optionalProducto.get();
            producto.setNombre(updateRequest.nombre());
            producto.setDescripcion(updateRequest.descripcion());
            producto.setImagen(updateRequest.imagen());
            producto.setStock(updateRequest.stock());
            producto.setPrecio(updateRequest.precio());
            producto.setPedidos(updateRequest.pedidos());
            return productoRepository.save(producto);
        }
        return null;
    }

    public void removeProducto(Long id) {
        productoRepository.deleteById(id);

    }

    public Optional<Producto> getProducto(final long id) {
        return productoRepository.findById(id);
    }

    public List<Producto> getAllProductos() {
        return productoRepository.findAll();
    }

}
