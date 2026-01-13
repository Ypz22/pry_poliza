class Automovil {
  final int? id;
  final String modelo;
  final double valor;
  final int accidentes;
  final int? propietarioId;

  Automovil({
    this.id,
    required this.modelo,
    required this.valor,
    required this.accidentes,
    this.propietarioId,
  });

  factory Automovil.fromJson(Map<String, dynamic> json) {
    return Automovil(
      id: json['id'],
      modelo: json['modelo'] ?? '',
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
      accidentes: json['accidentes'] ?? 0,
      // Accedemos al ID dentro del objeto propietario si la API lo envía anidado
      propietarioId: json['propietario'] != null ? json['propietario']['id'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "modelo": modelo,
      "valor": valor,
      "accidentes": accidentes,
      "propietario": {
        "id": propietarioId
      }
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Automovil && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}