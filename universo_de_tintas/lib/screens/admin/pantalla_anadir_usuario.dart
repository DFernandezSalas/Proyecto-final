import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/services/lista_usuarios.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';
import 'dart:io';

class PantallaAnadirUsuario extends StatefulWidget {
  const PantallaAnadirUsuario({super.key});

  @override
  State<PantallaAnadirUsuario> createState() => _PantallaAnadirUsuarioState();
}

class _PantallaAnadirUsuarioState extends State<PantallaAnadirUsuario> {
  final _formKey = GlobalKey<FormState>();
  final List<String> lugares = ["Zaragoza", "Huesca", "Teruel"];
  final ListaUsuarios listaUsuarios = ListaUsuarios();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();
  final TextEditingController _repitePasswordController =
      TextEditingController();
  String _lugarSeleccionado = "Zaragoza";
  String? _trato;
  bool _esAdmin = false;
  String? _imagenPath;

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagenSeleccionada =
        await picker.pickImage(source: ImageSource.gallery);

    if (imagenSeleccionada != null) {
      setState(() {
        _imagenPath = imagenSeleccionada.path;
      });
    }
  }

  void _anadirUsuario() {
    if (_formKey.currentState!.validate()) {
      if (_trato == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Debe seleccionar un trato (Sr. o Sra.)")),
        );
        return;
      }

      Usuario nuevoUsuario = Usuario(
        nombre: _nombreController.text,
        contrasenia: _contraseniaController.text,
        edad: int.parse(_edadController.text),
        lugarNacimiento: _lugarSeleccionado,
        trato: _trato!,
        esAdmin: _esAdmin,
        imagenPath: _imagenPath ?? "assets/images/imagen_defecto_user.png",
      );

      listaUsuarios.agregarUsuario(nuevoUsuario);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Trato:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        value: "Sr.",
                        groupValue: _trato,
                        onChanged: (String? value) {
                          setState(() {
                            _trato = value;
                          });
                        },
                        title: const Text("Sr."),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        value: "Sra.",
                        groupValue: _trato,
                        onChanged: (String? value) {
                          setState(() {
                            _trato = value;
                          });
                        },
                        title: const Text("Sra."),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese un nombre" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: "Edad"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese una edad" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _contraseniaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _repitePasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Repite Contraseña"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor repita la contraseña';
                  }
                  if (value != _contraseniaController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _lugarSeleccionado,
                decoration:
                    const InputDecoration(labelText: "Lugar de Nacimiento"),
                items: lugares.map((String lugar) {
                  return DropdownMenuItem(value: lugar, child: Text(lugar));
                }).toList(),
                onChanged: (nuevoLugar) {
                  setState(() {
                    _lugarSeleccionado = nuevoLugar!;
                  });
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _imagenPath != null
                        ? FileImage(File(_imagenPath!)) as ImageProvider
                        : const AssetImage(
                            "assets/images/imagen_defecto_user.png"),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _seleccionarImagen,
                    style: elevatedButtonStyle,
                    child: const Text("Cambiar Foto"),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CheckboxListTile(
                title: const Text("Es Administrador"),
                value: _esAdmin,
                onChanged: (bool? value) {
                  setState(() {
                    _esAdmin = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _anadirUsuario,
                style: elevatedButtonStyle,
                child: const Text("Añadir Usuario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
