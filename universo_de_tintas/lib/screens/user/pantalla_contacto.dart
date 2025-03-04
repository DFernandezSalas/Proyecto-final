import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaContacto extends StatelessWidget {
  const PantallaContacto({super.key});

  void abrirGoogleMaps() async {
    const url = "https://www.google.com/maps?q=Libros,Teruel,España";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "No se pudo abrir Google Maps";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacto")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Teléfono: +34 666 666 666", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Correo: contacto@universodetintas.com", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Página Web: www.universodetintas.com", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.map, color: Colors.blue),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: abrirGoogleMaps,
                  child: Text(
                    "Ver en Google Maps",
                    style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
