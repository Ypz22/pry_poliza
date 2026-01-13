class Propietario {
  final int? id;
  final String nombre;
  final String apellido;
  final int edad;

  Propietario({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.edad,
  });

  // Factory para crear una instancia desde JSON (respuesta de la API)
  factory Propietario.fromJson(Map<String, dynamic> json) {
    return Propietario(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      edad: json['edad'] ?? 0,
    );
  }

  // Método para convertir el objeto a JSON (para enviar en @RequestBody)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "apellido": apellido,
      "edad": edad,
    };
  }

  // Sobrecarga para comparación (equivalente a equals y hashCode de Java)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Propietario && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}