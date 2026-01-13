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
      propietarioId: json['propietario'] != null ? json['propietario']['id'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "modelo": modelo,
      "valor": valor,
      "accidentes": accidentes,
      "propietario": {
        "id": propietarioId
      }
    };
  }
}