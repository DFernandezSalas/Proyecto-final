class Usuario {
  String trato;
  String nombre;
  String contrasenia;
  int edad;
  String lugarNacimiento;
  String? imagenPath;
  bool esAdmin;
  bool bloqueado;

  Usuario({
    required this.trato,
    required this.nombre,
    required this.contrasenia,
    required this.edad,
    required this.lugarNacimiento,
    this.esAdmin = false,
    this.bloqueado = false,
    String? imagenPath,
  }) {
    this.imagenPath = (imagenPath == null || imagenPath.isEmpty)
        ? 'assets/images/imagen_defecto_user.png'
        : imagenPath;
  }
}
