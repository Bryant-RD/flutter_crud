import 'dart:convert';

import 'package:crud_cita/Entitys/Cliente.dart';
import 'package:crud_cita/Entitys/DetalleCita.dart';
import 'package:crud_cita/Entitys/Servicio.dart';
import 'package:http/http.dart' as http;

class ServiciosService {
  final String baseUrl = 'http://127.0.0.1:8080/servicios';

  Future<List<Servicio>> getServicios() async {
    final response = await http.get(Uri.parse("$baseUrl/"));
    print(response.body);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((cita) => Servicio.fromJson(cita))
          .toList();
    } else {
      throw Exception('Failed to fetch citas');
    }
  }

  Future<List<Empleado>> getEmpleados() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8080/empleado/"));
    print(response.body);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((empelado) => Empleado.fromJson(empelado))
          .toList();
    } else {
      throw Exception('Failed to fetch citas');
    }
  }

  Future<List<Cliente>> getClientes() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8080/cliente/listar"));
    print(response.body);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((empelado) => Cliente.fromJson(empelado))
          .toList();
    } else {
      throw Exception('Failed to fetch citas');
    }
  }
}
