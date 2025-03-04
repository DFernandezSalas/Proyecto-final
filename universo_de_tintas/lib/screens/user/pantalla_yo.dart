import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/user/pantalla_editar_perfil.dart';
import 'package:universo_de_tintas/screens/user/pantalla_contacto.dart';

class PantallaYo extends StatelessWidget {
  final Usuario usuario;
  const PantallaYo({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaEditarPerfil(usuario: usuario),
                  ),
                );
              },
              child: Text("Editar Usuario"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaContacto(),
                  ),
                );
              },
              child: Text("Contacto"),
            ),
          ],
        ),
      ),
    );
  }
}
