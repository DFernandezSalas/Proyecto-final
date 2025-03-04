import 'package:flutter/material.dart';
import 'package:universo_de_tintas/services/lista_pedidos.dart';
import 'package:universo_de_tintas/models/pedido.dart';
import 'package:universo_de_tintas/models/usuario.dart';

class PantallaPedidos extends StatefulWidget {
  final Usuario usuario;
  const PantallaPedidos({super.key, required this.usuario});

  @override
  State<PantallaPedidos> createState() => _PantallaPedidosState();
}

class _PantallaPedidosState extends State<PantallaPedidos> {
  @override
  Widget build(BuildContext context) {
    List<Pedido> pedidos = ListaPedidos.getPedidosUsuario(widget.usuario);

    return Scaffold(
      body: pedidos.isEmpty
          ? Center(child: Text("No tienes pedidos aún."))
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                var pedido = pedidos[index];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pedido #${pedido.id}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Estado: ${pedido.estado}",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children:
                              pedido.productos.asMap().entries.map((entry) {
                            int i = entry.key;
                            var producto = entry.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${pedido.cantidades[i]} x ${producto.nombre}"),
                                Text(
                                    "${(producto.precio * pedido.cantidades[i]).toStringAsFixed(2)} €"),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Total: ${pedido.total.toStringAsFixed(2)} €",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
