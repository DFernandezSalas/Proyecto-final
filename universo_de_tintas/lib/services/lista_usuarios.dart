import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/screens/pantalla_principal.dart';
import 'package:flutter/material.dart';



class ListaUsuarios {
  static final ListaUsuarios _instance = ListaUsuarios._internal();
  List<Usuario> usuarios = [];

  ListaUsuarios._internal();

  factory ListaUsuarios() {
    return _instance;
  }

  void agregarUsuario(Usuario usuario) {
    usuarios.add(usuario);
  }

Usuario? verificarUsuario(
      BuildContext context, String nombre, String contrasenia) {
    if (nombre == 'admin' && contrasenia == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PantallaPrincipal(usuario: null)),
      );
      return null;
    }

    for (var usuario in usuarios) {
      if (usuario.nombre == nombre && usuario.contrasenia == contrasenia) {
        return usuario;
      }
    }
    return null;
  }
}

