import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int paginaSeleccionada;
  final Function(int) onTabSelected;

  const BottomNavBar({
    Key? key,
    required this.paginaSeleccionada,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: paginaSeleccionada,
      onTap: onTabSelected,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Compras",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "Pedidos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Yo",
        ),
      ],
    );
  }
}
