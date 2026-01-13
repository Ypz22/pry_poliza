class Seguro {
  final int? id;
  final double costoTotal;
  final int? automovilId;

  Seguro({
    this.id,
    required this.costoTotal,
    this.automovilId,
  });

  // Factory para crear instancia desde JSON (SeguroDTO)
  factory Seguro.fromJson(Map<String, dynamic> json) {
    return Seguro(
      id: json['id'],
      costoTotal: (json['costoTotal'] as num?)?.toDouble() ?? 0.0,
      // Maneja si el JSON trae el objeto automovil completo o solo el ID
      automovilId: json['automovil'] != null ? json['automovil']['id'] : json['automovilId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "costoTotal": costoTotal,
      "automovilId": automovilId,
    };
  }
}