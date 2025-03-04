import 'package:flutter/material.dart';
import 'package:universo_de_tintas/screens/user/pantalla_pedidos.dart';
import 'package:universo_de_tintas/widgets/menu_drawer.dart';
import 'package:universo_de_tintas/widgets/bottom_nav_bar.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/user/pantalla_compras.dart';
import 'package:universo_de_tintas/screens/user/pantalla_yo.dart';


class PantallaPrincipal extends StatefulWidget {
  final Usuario usuario;

  const PantallaPrincipal({super.key, required this.usuario});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _paginaSeleccionada = 0;
  late Widget page;

  @override
  void initState() {
    super.initState();
    page = PantallaCompras(usuario: widget.usuario);
  }

  void _cambiarPagina(int index) {
    setState(() {
      _paginaSeleccionada = index;
      switch (index) {
        case 0:
          page = PantallaCompras(usuario: widget.usuario);
          break;
        case 1:
          page = PantallaPedidos(usuario: widget.usuario);
          break;
        case 2:
          page = PantallaYo(usuario: widget.usuario);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido ${widget.usuario.nombre}"),
      ),
      drawer: MenuDrawer(usuario: widget.usuario),
      body: page,
      bottomNavigationBar: BottomNavBar(
        paginaSeleccionada: _paginaSeleccionada,
        onTabSelected: _cambiarPagina,
      ),
    );
  }
}
