class Usuario {
  String trato;        
  String nombre;
  String contrasenia;   
  int edad;
  String lugarNacimiento;

  Usuario({
    required this.trato,
    required this.nombre,
    required this.contrasenia,
    required this.edad,
    required this.lugarNacimiento,
  });



  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      trato: map['trato'],
      nombre: map['nombre'],
      contrasenia: map['contraseña'],
      edad: map['edad'],
      lugarNacimiento: map['lugarNacimiento'],
    );
  }
}
