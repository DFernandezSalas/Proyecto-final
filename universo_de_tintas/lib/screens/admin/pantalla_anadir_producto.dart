import 'package:flutter/material.dart';
import 'package:universo_de_tintas/models/producto.dart';
import 'package:universo_de_tintas/services/lista_productos.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class PantallaAnadirProducto extends StatefulWidget {
  const PantallaAnadirProducto({super.key});

  @override
  State<PantallaAnadirProducto> createState() => _PantallaAnadirProductoState();
}

class _PantallaAnadirProductoState extends State<PantallaAnadirProducto> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  String? imagenPath;

  void anadirProducto() {
    if (_formKey.currentState!.validate()) {
      Producto nuevoProducto = Producto(
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        precio: double.parse(precioController.text),
        stock: int.parse(stockController.text),
        imagen: imagenPath ?? "assets/images/imagen_defecto.png",
      );

      ListaProductos.agregarProducto(nuevoProducto);
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
      appBar: AppBar(title: const Text("Añadir Producto")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese el nombre del producto" : null,
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
                ],
                decoration: const InputDecoration(labelText: "Precio (€)"),
                validator: (value) {
                  if (value!.isEmpty) return "Ingrese el precio";
                  if (double.tryParse(value) == null) return "Número inválido";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: stockController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: "Stock"),
                validator: (value) {
                  if (value!.isEmpty) return "Ingrese el stock";
                  if (int.tryParse(value) == null) return "Número inválido";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: seleccionarImagen,
                child: const Text("Seleccionar Imagen"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: anadirProducto,
                child: const Text("Añadir Producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
