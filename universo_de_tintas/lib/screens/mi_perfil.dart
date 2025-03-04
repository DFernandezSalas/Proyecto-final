import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/usuario.dart';

class MiPerfil extends StatelessWidget {
  final Usuario usuario;

  const MiPerfil({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: usuario.imagenPath != null
                  ? Image.asset(usuario.imagenPath!, width: 100, height: 100)
                  : Icon(Icons.person, size: 100), // Icono por defecto
            ),
            Text(
              'Trato: ${usuario.trato}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre: ${usuario.nombre}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Edad: ${usuario.edad}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Lugar de Nacimiento: ${usuario.lugarNacimiento}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Contraseña: ${usuario.contrasenia}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Regresar"),
            ),
          ],
        ),
      ),
    );
  }
}
