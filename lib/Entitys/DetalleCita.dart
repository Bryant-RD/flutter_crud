import 'package:crud_cita/Entitys/Cita.dart';
import 'package:crud_cita/Entitys/Servicio.dart';

class DetallesCita {
  int? id;

  Servicio servicio;
  Empleado empleado;

  DetallesCita({required this.servicio, required this.empleado});

  DetallesCita.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        servicio = Servicio.fromJson(json['servicio']),
        empleado = Empleado.fromJson(json['empleado']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['servicio'] = servicio.toJson();
    data['empleado'] = empleado.toJson();
    return data;
  }
}

class Empleado {
  int id;
  String nombre;
  String categoria;

  Empleado({required this.id, required this.nombre, required this.categoria});

  Empleado.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        categoria = json['categoria'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['categoria'] = categoria;
    return data;
  }
}
