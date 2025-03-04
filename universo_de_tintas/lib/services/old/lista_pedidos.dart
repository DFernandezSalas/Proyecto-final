import 'package:universo_de_tintas/models/pedido.dart';
import 'package:universo_de_tintas/models/usuario.dart';

class ListaPedidos {
  static List<Pedido> pedidos = [];

  static void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
  }

  static List<Pedido> getPedidosUsuario(Usuario usuario) {
    return pedidos
        .where((pedido) => pedido.usuario.nombre == usuario.nombre)
        .toList();
  }

  static List<Pedido> obtenerPedidos() {
    return pedidos;
  }
}
