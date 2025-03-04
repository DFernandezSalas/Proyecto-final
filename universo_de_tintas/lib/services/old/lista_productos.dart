import 'package:universo_de_tintas/models/producto.dart';

class ListaProductos {
  static final List<Producto> _productos = [
    Producto(
      nombre: "El Señor de los Anillos: La Comunidad del Anillo",
      descripcion: "Primer libro de la trilogía de J.R.R. Tolkien.",
      imagen: "assets/images/comunidad_anillo.jpg",
      stock: 10,
      precio: 25.99,
    ),
    Producto(
      nombre: "El Señor de los Anillos: Las Dos Torres",
      descripcion: "Segundo libro de la trilogía de J.R.R. Tolkien.",
      imagen: "assets/images/dos_torres.jpg",
      stock: 8,
      precio: 24.99,
    ),
    Producto(
      nombre: "El Señor de los Anillos: El Retorno del Rey",
      descripcion: "Último libro de la trilogía de J.R.R. Tolkien.",
      imagen: "assets/images/retorno_rey.jpg",
      stock: 12,
      precio: 26.99,
    ),
  ];

  static List<Producto> getProductos() {
    return _productos;
  }

  static void eliminarProducto(Producto producto) {
    _productos.removeWhere((p) => p.nombre == producto.nombre);
  }

  static void agregarProducto(Producto producto) {
    _productos.add(producto);
  }

  static void actualizarProducto(Producto producto, Producto productoActualizado) {
    int index = _productos.indexWhere((p) => p.nombre == producto.nombre);
    if (index != -1) {
      _productos[index] = productoActualizado;
    }
  }
}
