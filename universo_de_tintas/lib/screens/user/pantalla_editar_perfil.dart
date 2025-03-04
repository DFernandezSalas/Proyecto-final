import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';

class PantallaEditarPerfil extends StatefulWidget {
  final Usuario usuario;
  const PantallaEditarPerfil({super.key, required this.usuario});

  @override
  State<PantallaEditarPerfil> createState() => _PantallaEditarPerfilState();
}

class _PantallaEditarPerfilState extends State<PantallaEditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  final List<String> lugares = ["Zaragoza", "Huesca", "Teruel"];

  late TextEditingController nombreController;
  late TextEditingController edadController;
  late TextEditingController passwordController;
  late TextEditingController repitePasswordController;
  String? photoPath;
  String? _lugarSeleccionado;
  String? _trato;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.usuario.nombre);
    edadController = TextEditingController(text: widget.usuario.edad.toString());
    passwordController = TextEditingController(text: widget.usuario.contrasenia);
    repitePasswordController = TextEditingController(text: widget.usuario.contrasenia);
    _lugarSeleccionado = widget.usuario.lugarNacimiento;
    _trato = widget.usuario.trato;
    photoPath = widget.usuario.imagenPath;
  }

  void guardarCambios() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.usuario.nombre = nombreController.text;
        widget.usuario.edad = int.tryParse(edadController.text) ?? widget.usuario.edad;
        widget.usuario.contrasenia = passwordController.text;
        widget.usuario.lugarNacimiento = _lugarSeleccionado ?? widget.usuario.lugarNacimiento;
        widget.usuario.trato = _trato ?? widget.usuario.trato;
        widget.usuario.imagenPath = photoPath;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Datos actualizados correctamente.")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Trato:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
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
              const SizedBox(height: 20),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: edadController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: "Edad"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su edad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
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
                controller: repitePasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Repite Contraseña"),
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _lugarSeleccionado,
                decoration: const InputDecoration(labelText: "Lugar de Nacimiento"),
                items: lugares.map((String lugar) {
                  return DropdownMenuItem<String>(
                    value: lugar,
                    child: Text(lugar),
                  );
                }).toList(),
                onChanged: (String? nuevoLugar) {
                  setState(() {
                    _lugarSeleccionado = nuevoLugar;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Seleccione un lugar de nacimiento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Foto de perfil:"),
                  const SizedBox(width: 8),
                  ClipOval(
                    child: UniversalImage(
                      imagePath: photoPath,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () async {
                      final path = await CameraGalleryService().selectPhoto();
                      if (path == null) return;
                      setState(() {
                        photoPath = path;
                      });
                    },
                    child: const Text("Cambiar"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: guardarCambios,
                child: const Text("Guardar Cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );
    return photo?.path;
  }
}
