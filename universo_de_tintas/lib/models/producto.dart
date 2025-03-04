class Producto {
  int id;
  String nombre;
  String descripcion;
  String? imagen;
  int stock;
  double precio;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.imagen,
    required this.stock,
    required this.precio,
  }) {
    imagen ??= 'assets/images/default_book_image.png';
  }

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'] ?? 'assets/images/default_book_image.png',
      stock: json['stock'] ?? 0,
      precio: json['precio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "imagen": imagen,
      "stock": stock,
      "precio": precio,
    };
  }
}
