import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/automovil.dart';

class AutomovilController extends ChangeNotifier {
  final String _baseUrl = "http://10.40.6.234:9090/bbd_dto/api/automoviles";

  List<Automovil> automoviles = [];
  bool isLoading = false;

  // GET: Obtener todos los automóviles
  Future<void> fetchAutomoviles() async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        automoviles = data.map((json) => Automovil.fromJson(json)).toList();
      } else {
        debugPrint("Error al obtener automóviles: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error de conexión: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> crearAutomovil(Automovil automovil) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(automovil.toJson()),
      );

      if (response.statusCode == 201) {
        await fetchAutomoviles();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al crear: $e");
      return false;
    }
  }

  Future<bool> actualizarAutomovil(int id, Automovil automovil) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(automovil.toJson()),
      );

      if (response.statusCode == 200) {
        await fetchAutomoviles();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al actualizar: $e");
      return false;
    }
  }

  Future<bool> eliminarAutomovil(int id) async {
    try {
      final response = await http.delete(Uri.parse("$_baseUrl/$id"));

      if (response.statusCode == 204 || response.statusCode == 200) {
        automoviles.removeWhere((auto) => auto.id == id);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al eliminar: $e");
      return false;
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}