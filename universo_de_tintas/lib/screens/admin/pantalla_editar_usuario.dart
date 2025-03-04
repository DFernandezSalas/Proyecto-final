import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/services/old/lista_usuarios.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';

class PantallaEditarUsuario extends StatefulWidget {
  final Usuario usuario;

  const PantallaEditarUsuario({super.key, required this.usuario});

  @override
  State<PantallaEditarUsuario> createState() => _PantallaEditarUsuarioState();
}

class _PantallaEditarUsuarioState extends State<PantallaEditarUsuario> {
  final _formKey = GlobalKey<FormState>();
  final List<String> lugares = ["Zaragoza", "Huesca", "Teruel"];
  final ListaUsuarios listaUsuarios = ListaUsuarios();

  late TextEditingController _nombreController;
  late TextEditingController _edadController;
  late TextEditingController _contraseniaController;
  late TextEditingController _repitePasswordController;
  late String _lugarSeleccionado;
  late String? _trato;
  late bool _esAdmin;
  String? _imagenPath;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.usuario.nombre);
    _edadController =
        TextEditingController(text: widget.usuario.edad.toString());
    _contraseniaController =
        TextEditingController(text: widget.usuario.contrasenia);
    _repitePasswordController =
        TextEditingController(text: widget.usuario.contrasenia);
    _lugarSeleccionado = widget.usuario.lugarNacimiento;
    _trato = widget.usuario.trato;
    _esAdmin = widget.usuario.esAdmin;
    _imagenPath = widget.usuario.imagenPath;
  }

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

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      if (_trato == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Debe seleccionar un trato (Sr. o Sra.)")),
        );
        return;
      }

      Usuario usuarioEditado = Usuario(
        nombre: _nombreController.text,
        contrasenia: _contraseniaController.text,
        edad: int.parse(_edadController.text),
        lugarNacimiento: _lugarSeleccionado,
        trato: _trato!,
        esAdmin: _esAdmin,
        imagenPath: _imagenPath ?? "assets/images/imagen_defecto_user.png",
      );

      listaUsuarios.actualizarUsuario(widget.usuario, usuarioEditado);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Usuario")),
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
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: UniversalImage(
                        imagePath: _imagenPath,
                        width: 80,
                        height: 80,
                      ),
                    ),
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
                onPressed: _guardarCambios,
                style: elevatedButtonStyle,
                child: const Text("Guardar Cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
