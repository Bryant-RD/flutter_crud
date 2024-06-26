import 'package:crud_cita/Entitys/Cliente.dart';
import 'package:crud_cita/Entitys/DetalleCita.dart';

class Cita {
  int id;
  String fecha;
  String hora;
  Cliente cliente;
  List<DetallesCita> detallesCitas;

  Cita(
      {required this.id,
      required this.fecha,
      required this.hora,
      required this.cliente,
      required this.detallesCitas});

  Cita.fromJson(Map<String, dynamic> json)
      : cliente = Cliente.fromJson(json['cliente']),
        id = json['id'],
        fecha = json['fecha'],
        hora = json['hora'],
        detallesCitas = json['detallesCita'] != null
            ? (json['detallesCita'] as List<dynamic>)
                .map((item) => DetallesCita.fromJson(item))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fecha'] = fecha;
    data['hora'] = hora;
    data['cliente'] = cliente.toJson();
    data['detallesCita'] = detallesCitas.map((v) => v.toJson()).toList();
    return data;
  }
}
