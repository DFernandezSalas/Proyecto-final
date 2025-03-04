import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/producto.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_anadir_producto.dart';
import 'package:universo_de_tintas/services/old/lista_productos.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_editar_producto.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';
import 'package:universo_de_tintas/widgets/menu_drawer.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';

class PantallaGestionProductos extends StatefulWidget {
  final Usuario usuario;
  const PantallaGestionProductos({super.key, required this.usuario});

  @override
  State<PantallaGestionProductos> createState() =>
      _PantallaGestionProductosState();
}

class _PantallaGestionProductosState extends State<PantallaGestionProductos> {
  void _confirmarEliminar(Producto producto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar Producto"),
          content: Text("¿Seguro que quieres eliminar ${producto.nombre}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  ListaProductos.eliminarProducto(producto);
                });
                Navigator.pop(context);
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  void _editarProducto(Producto producto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaEditarProducto(producto: producto),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Producto> productos = ListaProductos.getProductos();

    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Productos")),
      drawer: MenuDrawer(usuario: widget.usuario),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          Producto producto = productos[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
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
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("Stock: ${producto.stock}"),
                        Text("${producto.precio.toStringAsFixed(2)} €"),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _editarProducto(producto),
                        icon: const Icon(Icons.edit),
                        label: const Text("Editar"),
                        style: elevatedButtonStyle,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton.icon(
                        onPressed: () => _confirmarEliminar(producto),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text("Eliminar"),
                        style: elevatedButtonStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
  mainAxisAlignment: MainAxisAlignment.end, // Alinea los botones a la derecha
  children: [
    FloatingActionButton(
      onPressed: () {
        Navigator.pop(context); // Botón de volver atrás
      },
      heroTag: "btn_volver",
      child: const Icon(Icons.arrow_back),
      backgroundColor: Colors.red,
    ),
    const SizedBox(width: 10), // Espacio entre los botones
    FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PantallaAnadirProducto()),
        ).then((_) {
          setState(() {});
        });
      },
      heroTag: "btn_anadir",
      child: const Icon(Icons.add),
    ),
  ],
),

    );
  }
}
