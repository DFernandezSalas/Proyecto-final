import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_gestion_productos.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_gestion_usuarios.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_gestion_pedidos.dart';
import 'package:universo_de_tintas/widgets/menu_drawer.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';

class PantallaAdmin extends StatelessWidget {
  final Usuario usuario;

  const PantallaAdmin({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panel de Administrador")),
      drawer: MenuDrawer(usuario: usuario),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GestionUsuarios(usuario: usuario)),
                  );
                },
                child: const Text("Gestionar Usuarios"),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PantallaGestionPedidos(usuario: usuario)),
                  );
                },
                child: const Text("Gestionar Pedidos"),
              ),
            ),

            SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PantallaGestionProductos(usuario: usuario)),
                  );
                },
                child: const Text("Gestionar Productos"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
