import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/poliza.dart';

class PolizaController extends ChangeNotifier {
  final String _baseUrl = "http://10.0.2.2:8080/api/poliza";

  PolizaResponse? ultimaPoliza;
  bool isLoading = false;

  Future<bool> generarPolizaCompleta(PolizaRequest req) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(req.toJson()),
      );

      if (response.statusCode == 200) {
        ultimaPoliza = PolizaResponse.fromJson(json.decode(response.body));
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al generar póliza: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}