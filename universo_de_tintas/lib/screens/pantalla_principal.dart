import 'package:universo_de_tintas/screens/login.dart';
import 'package:universo_de_tintas/screens/mi_perfil.dart';
import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:flutter/services.dart';

class PantallaPrincipal extends StatefulWidget {
  final Usuario? usuario;
  const PantallaPrincipal({super.key, required this.usuario});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Principal"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(widget.usuario != null
                  ? 'Bienvenido, ${widget.usuario!.nombre}'
                  : 'Bienvenido, Invitado'),
            ),
            ListTile(
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            ListTile(
              title: Text('Mi Perfil'),
              onTap: () {
                if (widget.usuario != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MiPerfil(usuario: widget.usuario!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No tienes perfil disponible")),
                  );
                }
              },
            ),
            ListTile(
              title: Text('Salir'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmar'),
                    content: Text('¿Seguro que deseas salir de la aplicación?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Salir'),
                        onPressed: () {
                          Navigator.pop(context);
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Contenido de la pantalla principal"),

            SizedBox(height: 20), 

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Volver al Login"),
            ),
          ],
        ),
      ),
    );
  }
}
