import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/seguro.dart';

class SeguroController extends ChangeNotifier {
  final String _baseUrl = "http://10.40.6.234:9090/bbd_dto/api/seguros";

  Seguro? seguroActual;
  bool isLoading = false;

  // GET /api/seguros/automovil/{automovilId}
  Future<void> fetchSeguroPorAutomovil(int automovilId) async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse("$_baseUrl/automovil/$automovilId"));
      if (response.statusCode == 200) {
        seguroActual = Seguro.fromJson(json.decode(response.body));
      } else {
        seguroActual = null;
      }
    } catch (e) {
      debugPrint("Error al obtener seguro: $e");
    } finally {
      _setLoading(false);
    }
  }

  // POST /api/seguros/recalcular/{automovilId}
  Future<bool> recalcularSeguro(int automovilId) async {
    _setLoading(true);
    try {
      final response = await http.post(Uri.parse("$_baseUrl/recalcular/$automovilId"));
      if (response.statusCode == 200) {
        seguroActual = Seguro.fromJson(json.decode(response.body));
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al recalcular: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // DELETE /api/seguros/automovil/{automovilId}
  Future<bool> eliminarSeguro(int automovilId) async {
    try {
      final response = await http.delete(Uri.parse("$_baseUrl/automovil/$automovilId"));
      if (response.statusCode == 204 || response.statusCode == 200) {
        seguroActual = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al eliminar seguro: $e");
      return false;
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}