class Servicio {
  late int id;
  late String nombre;
  late double precio;
  late String categoria;

  Servicio(
      {required this.id,
      required this.nombre,
      required this.precio,
      required this.categoria});

  Servicio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    precio = json['precio'];
    categoria = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['precio'] = precio;
    data['categoria'] = categoria;
    return data;
  }
}
