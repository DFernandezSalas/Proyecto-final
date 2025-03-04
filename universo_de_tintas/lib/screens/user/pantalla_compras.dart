import 'package:flutter/material.dart';
import 'package:universo_de_tintas/services/old/lista_productos.dart';
import 'package:universo_de_tintas/models/producto.dart';
import 'package:universo_de_tintas/services/old/lista_pedidos.dart';
import 'package:universo_de_tintas/models/pedido.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';

class PantallaCompras extends StatefulWidget {
  final Usuario usuario;
  const PantallaCompras({super.key, required this.usuario});

  @override
  State<PantallaCompras> createState() => _PantallaComprasState();
}

class _PantallaComprasState extends State<PantallaCompras> {
  List<int> cantidades = List.filled(ListaProductos.getProductos().length, 0);

  double calcularTotal() {
    double total = 0;
    for (int i = 0; i < cantidades.length; i++) {
      total += cantidades[i] * ListaProductos.getProductos()[i].precio;
    }
    return total;
  }

  void realizarCompra() {
    bool carritoVacio = cantidades.every((cantidad) => cantidad == 0);

    if (carritoVacio) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No hay productos en el carrito.")),
      );
      return;
    }

    List<Producto> productosComprados = [];
    List<int> cantidadesCompradas = [];

    for (int i = 0; i < cantidades.length; i++) {
      if (cantidades[i] > 0) {
        productosComprados.add(ListaProductos.getProductos()[i]);
        cantidadesCompradas.add(cantidades[i]);
        ListaProductos.getProductos()[i].stock -= cantidades[i];
      }
    }

    Pedido nuevoPedido = Pedido(
      usuario: widget.usuario,
      productos: productosComprados,
      cantidades: cantidadesCompradas,
    );

    ListaPedidos.agregarPedido(nuevoPedido);

    setState(() {
      cantidades = List.filled(cantidades.length, 0);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Pedido realizado con éxito.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Producto> productos = ListaProductos.getProductos();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                var producto = productos[index];

                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: UniversalImage(
                            imagePath: producto.imagen,
                            width: 100,
                            height: 150,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto.nombre,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                producto.descripcion,
                                style: TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Stock: ${producto.stock}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${producto.precio.toStringAsFixed(2)} €",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (cantidades[index] > 0)
                                          cantidades[index]--;
                                      });
                                    },
                                  ),
                                  Text("${cantidades[index]}"),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        if (cantidades[index] < producto.stock)
                                          cantidades[index]++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: realizarCompra,
              child: Text(
                  "Realizar Compra (${calcularTotal().toStringAsFixed(2)} €)"),
            ),
          ),
        ],
      ),
    );
  }
}
