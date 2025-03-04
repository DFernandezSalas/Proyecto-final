import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/admin/pantalla_admin.dart';

class ListaUsuarios {
  static final ListaUsuarios _instance = ListaUsuarios._internal();
  final List<Usuario> usuarios = [];

  factory ListaUsuarios() {
    return _instance;
  }

  void agregarUsuario(Usuario usuario) {
    usuarios.add(usuario);
  }

  void eliminarUsuario(Usuario usuario) {
    if (usuario.nombre == "admin") return;
    usuarios.remove(usuario);
  }

  ListaUsuarios._internal() {
    usuarios.add(Usuario(
      nombre: "David",
      contrasenia: "David",
      edad: 31,
      trato: "Sr.",
      lugarNacimiento: "Zaragoza",
      esAdmin: false,
      bloqueado: false,
    ));
  }

  Usuario? verificarUsuario(
      BuildContext context, String nombre, String contrasenia) {
    if (nombre == 'admin' && contrasenia == 'admin') {
      final Usuario admin = Usuario(
        nombre: "admin",
        contrasenia: "admin",
        edad: 99,
        trato: "Admin",
        lugarNacimiento: "Sistema",
        esAdmin: true,
        bloqueado: false,
      );

      Future.microtask(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PantallaAdmin(usuario: admin)),
        );
      });

      return admin;
    }

    for (var usuario in usuarios) {
      if (usuario.nombre == nombre && usuario.contrasenia == contrasenia) {
        if (usuario.bloqueado) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Este usuario está bloqueado.")),
          );
          return null;
        }

        return usuario;
      }
    }

    return null;
  }

  List<Usuario> obtenerUsuarios() {
    return usuarios;
  }

  void actualizarUsuario(Usuario usuarioViejo, Usuario usuarioNuevo) {
    int index = usuarios.indexOf(usuarioViejo);
    if (index != -1) {
      usuarios[index] = usuarioNuevo;
    }
  }
}
