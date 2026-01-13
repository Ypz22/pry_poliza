import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/propietario.dart';

class PropietarioController extends ChangeNotifier {
  // Ajusta la URL según tu entorno (10.0.2.2 es el localhost para el emulador Android)
  final String _baseUrl = "http://10.40.6.234:9090/bbd_dto/api/propietarios";

  List<Propietario> propietarios = [];
  bool isLoading = false;

  // GET /api/propietarios (obtenerTodosLosPropietarios)
  Future<void> fetchPropietarios() async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        propietarios = data.map((item) => Propietario.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint("Error al cargar propietarios: $e");
    } finally {
      _setLoading(false);
    }
  }

  // POST /api/propietarios (crearPropietario)
  Future<bool> crearPropietario(Propietario propietario) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(propietario.toJson()),
      );
      if (response.statusCode == 201) {
        await fetchPropietarios(); // Recargar lista
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al crear: $e");
      return false;
    }
  }

  // PUT /api/propietarios/{id} (actualizarPropietario)
  Future<bool> actualizarPropietario(int id, Propietario propietario) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(propietario.toJson()),
      );
      if (response.statusCode == 200) {
        await fetchPropietarios();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al actualizar: $e");
      return false;
    }
  }

  // DELETE /api/propietarios/{id} (eliminarPropietario)
  Future<bool> eliminarPropietario(int id) async {
    try {
      final response = await http.delete(Uri.parse("$_baseUrl/$id"));
      if (response.statusCode == 204 || response.statusCode == 200) {
        propietarios.removeWhere((p) => p.id == id);
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