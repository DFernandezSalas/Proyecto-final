import 'dart:math';
import 'package:universo_de_tintas/models/producto.dart';
import 'package:universo_de_tintas/models/usuario.dart';

class Pedido {
  final int id;
  final Usuario usuario;
  final List<Producto> productos;
  final List<int> cantidades;
  double total;
  String estado;

  Pedido({
    required this.usuario,
    required this.productos,
    required this.cantidades,
  })  : id = Random().nextInt(999999),
        total = _calcularTotal(productos, cantidades),
        estado = "Pedido";

  static double _calcularTotal(List<Producto> productos, List<int> cantidades) {
    double total = 0;
    for (int i = 0; i < productos.length; i++) {
      total += productos[i].precio * cantidades[i];
    }
    return total;
  }
}
