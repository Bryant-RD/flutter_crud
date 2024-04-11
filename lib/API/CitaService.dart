import 'dart:convert';

import 'package:crud_cita/Entitys/Cita.dart';
import 'package:http/http.dart' as http;

class CitaService {
  final String baseUrl = 'http://127.0.0.1:8080/cita';

  Future<List<Cita>> getCitas() async {
    final response = await http.get(Uri.parse(baseUrl + "/"));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((cita) => Cita.fromJson(cita))
          .toList();
    } else {
      throw Exception('Failed to fetch citas');
    }
  }

  Future<Cita> getCita(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch cita');
    }
  }

  Future<int> createCita(Cita citaData) async {
    print("CITA ENTRANTE: \n ${jsonEncode(citaData.toJson())}");
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/nuevaCita"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(citaData.toJson()),
      );

      // return Cita.fromJson(jsonDecode(response.body)).id;
      // print(Cita.fromJson(jsonDecode(response.body)).detallesCitas.length);

      return response.statusCode;
    } catch (e) {
      print(e);
      throw Exception('Failed to create cita: $e');
    }
  }

  Future<Cita> updateCita(int id, Map<String, dynamic> citaData) async {
    print('$baseUrl/$id');
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(citaData),
      );

      if (response.statusCode == 200) {
        return Cita.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to update cita. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to update cita');
    }
  }

  Future<void> deleteCita(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
    } catch (e) {
      print("ERROR: $e");
      throw Exception('Failed to delete cita');
    }
  }
}
