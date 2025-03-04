class Usuario {
  int id;
  String trato;
  String nombre;
  String contrasenia;
  int edad;
  String lugarNacimiento;
  String? imagenPath;
  bool esAdmin;
  bool bloqueado;

  Usuario({
    required this.id,
    required this.trato,
    required this.nombre,
    required this.contrasenia,
    required this.edad,
    required this.lugarNacimiento,
    this.imagenPath,
    this.esAdmin = false,
    this.bloqueado = false,
  }) {
    imagenPath ??= 'assets/images/imagen_defecto_user.png';
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] ?? 0,
      trato: json['trato'] ?? '',
      nombre: json['nombre'] ?? '',
      contrasenia: json['contrasenia'] ?? '',
      edad: json['edad'] ?? 0,
      lugarNacimiento: json['lugarNacimiento'] ?? '',
      imagenPath: json['imagen'] ?? 'assets/images/imagen_defecto_user.png',
      esAdmin: json['administrador'] ?? false,
      bloqueado: json['bloqueado'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "trato": trato,
      "nombre": nombre,
      "contrasenia": contrasenia,
      "edad": edad,
      "lugarNacimiento": lugarNacimiento,
      "imagen": imagenPath,
      "administrador": esAdmin,
      "bloqueado": bloqueado,
    };
  }
}
