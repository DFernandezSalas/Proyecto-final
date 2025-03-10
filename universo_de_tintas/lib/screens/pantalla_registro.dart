import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universo_de_tintas/models/usuario.dart';
import 'package:universo_de_tintas/services/lista_usuarios.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universo_de_tintas/utils/button_styles.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final List<String> lugares = ["Zaragoza", "Huesca", "Teruel"];

  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repitePasswordController =
      TextEditingController();
  final TextEditingController _lugarNacimientoController =
      TextEditingController();
  String? photoPath;
  String? _lugarSeleccionado;
  String? _trato;
  bool _aceptaTerminos = false;
  final ListaUsuarios listaUsuarios = ListaUsuarios();

  void _crearUsuario() {
    if (_formKey.currentState!.validate()) {
      if (_trato == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Debe seleccionar un trato (Sr. o Sra.)")),
        );
        return;
      }

      if (!_aceptaTerminos) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Debe aceptar los términos y condiciones")),
        );
        return;
      }

      Usuario nuevoUsuario = Usuario(
        nombre: _usuarioController.text,
        contrasenia: _passwordController.text,
        edad: int.tryParse(_edadController.text) ?? 0,
        lugarNacimiento: _lugarSeleccionado ?? "",
        trato: _trato!,
        imagenPath: photoPath,
      );

      listaUsuarios.agregarUsuario(nuevoUsuario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario creado correctamente")),
      );

      _usuarioController.clear();
      _passwordController.clear();
      _repitePasswordController.clear();
      _edadController.clear();
      _lugarNacimientoController.clear();
      setState(() {
        _trato = null;
        _aceptaTerminos = false;
      });

      Navigator.pop(context);
    }
  }

  void _cancelarRegistro() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Trato:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        title: Text("Sr."),
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
                        title: Text("Sra."),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              //Usuario
              TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: "Usuario",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre de usuario';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),
              //Contraseña
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Repite contraseña
              TextFormField(
                controller: _repitePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Repite Contraseña",
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor repita la contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              //Edad
              TextFormField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Edad",
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su edad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Alinea todo a la izquierda
                children: [
                  Text("Subir foto: "),
                  SizedBox(width: 8), // Espacio pequeño entre texto y botón
                  ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () async {
                      final path = await CameraGalleryService().selectPhoto();
                      if (path == null) return;
                      setState(() {
                        photoPath = path;
                      });
                    },
                    child: Text("Seleccionar"),
                  ),
                ],
              ),

              SizedBox(height: 15),

              //Nacimiento
              DropdownButtonFormField<String>(
                value: _lugarSeleccionado,
                decoration: InputDecoration(
                  labelText: "Lugar de Nacimiento",
                  prefixIcon: Icon(Icons.location_city),
                ),
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
                    return 'Por favor seleccione un lugar de nacimiento';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              //Terminos
              CheckboxListTile(
                title: Text("Acepto los términos y condiciones"),
                value: _aceptaTerminos,
                onChanged: (bool? value) {
                  setState(() {
                    _aceptaTerminos = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              //Crear usuario
              ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: _crearUsuario,
                child: Text("Crear Usuario"),
              ),
              SizedBox(height: 15),

              //Cancelar
              OutlinedButton(
                style: outlinedButtonStyle,
                onPressed: _cancelarRegistro,
                child: Text("Cancelar"),
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
    if (photo == null) return null;
    return photo.path;
  }

  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (photo == null) return null;

    return photo.path;
  }
}
