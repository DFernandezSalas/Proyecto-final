import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/services/lista_usuarios.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_editar_usuario.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_anadir_usuario.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';
import 'package:universo_de_tintas/widgets/menu_drawer.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';

class GestionUsuarios extends StatefulWidget {
  final Usuario usuario;
  const GestionUsuarios({super.key, required this.usuario});
  

  @override
  State<GestionUsuarios> createState() => _GestionUsuariosState();
}

class _GestionUsuariosState extends State<GestionUsuarios> {
  final ListaUsuarios listaUsuarios = ListaUsuarios();

  void _confirmarEliminar(Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar Usuario"),
          content: Text("¿Seguro que quieres eliminar a ${usuario.nombre}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  listaUsuarios.eliminarUsuario(usuario);
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

  void _confirmarBloqueo(Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: usuario.bloqueado
              ? const Text("Desbloquear Usuario")
              : const Text("Bloquear Usuario"),
          content: Text(
              "¿Seguro que quieres ${usuario.bloqueado ? "desbloquear" : "bloquear"} a ${usuario.nombre}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  usuario.bloqueado = !usuario.bloqueado;
                });
                Navigator.pop(context);
              },
              child: Text(usuario.bloqueado ? "Desbloquear" : "Bloquear"),
            ),
          ],
        );
      },
    );
  }

  void _anadirUsuario() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaAnadirUsuario()),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Usuario> usuarios = listaUsuarios.obtenerUsuarios();

    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Usuarios")),
      drawer: MenuDrawer(usuario: widget.usuario),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          Usuario usuario = usuarios[index];

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
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: UniversalImage(
                        imagePath: usuario.imagenPath,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usuario.nombre,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("Edad: ${usuario.edad}"),
                        Text(usuario.esAdmin ? "Administrador" : "Usuario"),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PantallaEditarUsuario(usuario: usuario),
                            ),
                          ).then((_) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Editar"),
                        style: elevatedButtonStyle,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton.icon(
                        onPressed: () => _confirmarEliminar(usuario),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text("Eliminar"),
                        style: elevatedButtonStyle,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton.icon(
                        onPressed: () => _confirmarBloqueo(usuario),
                        icon: Icon(
                          usuario.bloqueado ? Icons.lock : Icons.lock_open,
                          color: usuario.bloqueado ? Colors.red : Colors.green,
                        ),
                        label:
                            Text(usuario.bloqueado ? "Desbloquear" : "Bloquear"),
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
      heroTag: "btn_volver_usuarios",
      child: const Icon(Icons.arrow_back),
      backgroundColor: Colors.red,
    ),
    const SizedBox(width: 10), // Espacio entre los botones
    FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PantallaAnadirUsuario()), // Navegar a la pantalla de añadir usuario
        ).then((_) {
          setState(() {});
        });
      },
      heroTag: "btn_anadir_usuario",
      child: const Icon(Icons.add),
    ),
  ],
),

    );
  }
}
