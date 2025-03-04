import 'package:universo_de_tintas/screens/admin/pantalla_admin.dart';
import 'package:universo_de_tintas/screens/pantalla_registro.dart';
import 'package:universo_de_tintas/screens/user/pantalla_principal.dart';
import 'package:flutter/material.dart';
import 'package:universo_de_tintas/services/lista_usuarios.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ListaUsuarios listaUsuarios =
      ListaUsuarios(); // Instancia de la lista de usuarios

  void _login() {
    String username = _userController.text;
    String password = _passController.text;

    Usuario? usuario =
        listaUsuarios.verificarUsuario(context, username, password);

    if (usuario != null && !usuario.esAdmin) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PantallaPrincipal(usuario: usuario)),
      );
    } else if (usuario != null && usuario.esAdmin) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PantallaAdmin(usuario: usuario)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
  }

  void _mostrarRecuperarContrasenia() {
    TextEditingController usuarioController = TextEditingController();
    String? mensaje;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Recuperar Contraseña"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Ingresa tu usuario para recuperar la contraseña:"),
                  TextField(
                    controller: usuarioController,
                    decoration: InputDecoration(labelText: "Usuario"),
                  ),
                  if (mensaje != null)
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        mensaje!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    String nombre = usuarioController.text.trim();
                    Usuario? usuario = listaUsuarios.usuarios.firstWhere(
                      (u) => u.nombre == nombre,
                      orElse: () => Usuario(
                          nombre: "",
                          contrasenia: "",
                          edad: 0,
                          trato: "",
                          lugarNacimiento: ""),
                    );

                    setState(() {
                      if (usuario.nombre.isNotEmpty) {
                        mensaje = "Tu contraseña es: ${usuario.contrasenia}";
                      } else {
                        mensaje = "Usuario no encontrado";
                      }
                    });
                  },
                  child: Text("Enviar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PantallaRegistro()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Universos de tintas",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/logouniversosdetintasdark.png',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: "Usuario",
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _mostrarRecuperarContrasenia,
                child: Text("¿Olvidaste tu contraseña?"),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: _login,
                  style: elevatedButtonStyle,
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: OutlinedButton(
                  onPressed: _register,
                  style: outlinedButtonStyle,
                  child: Text(
                    "Registrar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ])));
  }
}
