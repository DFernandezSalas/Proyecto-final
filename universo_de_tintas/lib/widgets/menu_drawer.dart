import 'package:flutter/material.dart';
import 'package:universo_de_tintas/screens/login.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/mi_perfil.dart';
import 'package:flutter/services.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';

class MenuDrawer extends StatelessWidget {
  final Usuario usuario;

  const MenuDrawer({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido ${usuario.nombre}',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                ClipOval(
                  child: UniversalImage(
                    imagePath: usuario.imagenPath,
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Mi Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MiPerfil(usuario: usuario)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Salir'),
            onTap: () {
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
    );
  }
}
