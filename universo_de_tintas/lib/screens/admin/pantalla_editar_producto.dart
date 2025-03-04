import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universo_de_tintas/models/producto.dart';
import 'package:universo_de_tintas/widgets/universal_image.dart';
import 'package:image_picker/image_picker.dart';

class PantallaEditarProducto extends StatefulWidget {
  final Producto producto;

  const PantallaEditarProducto({super.key, required this.producto});

  @override
  State<PantallaEditarProducto> createState() => _PantallaEditarProductoState();
}

class _PantallaEditarProductoState extends State<PantallaEditarProducto> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  late TextEditingController precioController;
  late TextEditingController stockController;
  String? imagenPath;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.producto.nombre);
    descripcionController =
        TextEditingController(text: widget.producto.descripcion);
    precioController =
        TextEditingController(text: widget.producto.precio.toString());
    stockController =
        TextEditingController(text: widget.producto.stock.toString());
    imagenPath = widget.producto.imagen;
  }

  void guardarCambios() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.producto.nombre = nombreController.text;
        widget.producto.descripcion = descripcionController.text;
        widget.producto.precio = double.parse(precioController.text);
        widget.producto.stock = int.parse(stockController.text);
        widget.producto.imagen = imagenPath ?? widget.producto.imagen;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Producto actualizado correctamente.")),
      );

      Navigator.pop(context);
    }
  }

  Future<void> seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);

    if (imagen != null) {
      setState(() {
        imagenPath = imagen.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Producto")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese un nombre" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: "Descripción"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese una descripción" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: precioController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
                ],
                decoration: const InputDecoration(labelText: "Precio (€)"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese un precio" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: stockController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: "Stock"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese el stock" : null,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  UniversalImage(
                      imagePath: imagenPath ?? "", width: 100, height: 100),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: seleccionarImagen,
                    child: const Text("Cambiar Imagen"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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
