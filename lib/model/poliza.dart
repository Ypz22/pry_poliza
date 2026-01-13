class PolizaRequest {
  final String propietario;
  final int edadPropietario;
  final String modeloAuto;
  final double valorSeguroAuto;
  final int accidentes;

  PolizaRequest({
    required this.propietario,
    required this.edadPropietario,
    required this.modeloAuto,
    required this.valorSeguroAuto,
    required this.accidentes,
  });

  Map<String, dynamic> toJson() => {
    "propietario": propietario,
    "edadPropietario": edadPropietario,
    "modeloAuto": modeloAuto,
    "valorSeguroAuto": valorSeguroAuto,
    "accidentes": accidentes,
  };
}

class PolizaResponse {
  final String nombreCompleto;
  final String modelo;
  final double valor;
  final int edad;
  final int accidentes;
  final double costoTotal;

  PolizaResponse({
    required this.nombreCompleto,
    required this.modelo,
    required this.valor,
    required this.edad,
    required this.accidentes,
    required this.costoTotal,
  });

  factory PolizaResponse.fromJson(Map<String, dynamic> json) => PolizaResponse(
    nombreCompleto: json['nombreCompleto'] ?? '',
    modelo: json['modelo'] ?? '',
    valor: (json['valor'] as num).toDouble(),
    edad: json['edad'] ?? 0,
    accidentes: json['accidentes'] ?? 0,
    costoTotal: (json['costoTotal'] as num).toDouble(),
  );
}