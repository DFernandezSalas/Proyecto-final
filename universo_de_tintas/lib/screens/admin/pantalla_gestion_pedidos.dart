import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/pedido.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/services/old/lista_pedidos.dart';
import 'package:universo_de_tintas/widgets/menu_drawer.dart';

class PantallaGestionPedidos extends StatefulWidget {
  final Usuario usuario;
  const PantallaGestionPedidos({super.key, required this.usuario});

  @override
  State<PantallaGestionPedidos> createState() => _PantallaGestionPedidosState();
}

class _PantallaGestionPedidosState extends State<PantallaGestionPedidos> {
  final List<String> estadosPedido = [
    "Pedido",
    "En Producción",
    "En Reparto",
    "Entregado"
  ];

  void _cambiarEstadoPedido(Pedido pedido, String nuevoEstado) {
    setState(() {
      pedido.estado = nuevoEstado;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Pedido> pedidos = ListaPedidos.obtenerPedidos();

    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Pedidos")),
      drawer: MenuDrawer(usuario: widget.usuario),
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          Pedido pedido = pedidos[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pedido de ${pedido.usuario.nombre}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text("Estado del pedido:"),
                  DropdownButton<String>(
                    value: pedido.estado,
                    items: estadosPedido.map((String estado) {
                      return DropdownMenuItem(
                        value: estado,
                        child: Text(estado),
                      );
                    }).toList(),
                    onChanged: (nuevoEstado) {
                      if (nuevoEstado != null) {
                        _cambiarEstadoPedido(pedido, nuevoEstado);
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  const Text("Productos:"),
                  Column(
                    children: List.generate(
                      pedido.productos.length,
                      (i) => Text(
                        "${pedido.productos[i].nombre} - ${pedido.cantidades[i]} uds",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Vuelve a la pantalla anterior
        },
        heroTag: "btn_volver_pedidos",
        child: const Icon(Icons.arrow_back),
        backgroundColor: Colors.red, // Color rojo para diferenciarlo
      ),
    );
  }
}
