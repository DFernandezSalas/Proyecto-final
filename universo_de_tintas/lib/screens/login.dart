import 'package:universo_de_tintas/screens/pantalla_registro.dart';
import 'package:universo_de_tintas/screens/pantalla_principal.dart';
import 'package:flutter/material.dart';
import 'package:universo_de_tintas/services/lista_usuarios.dart';
import 'package:universo_de_tintas/models/usuario.dart';

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

    // Verificar si el usuario y la contraseña son correctos
    Usuario? usuario =
        listaUsuarios.verificarUsuario(context, username, password);

    if (usuario != null) {
      // Si el usuario existe, ir a la pantalla principal
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PantallaPrincipal(
                usuario:
                    usuario)), // Asegúrate de que la pantalla principal exista
      );
    } else {
      // Si el usuario o la contraseña son incorrectos, mostrar un error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
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
        body: Container(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logouniversosdetintasdark.png',
                      width: 300,
                      height: 300,
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
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
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
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          "Registrar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
