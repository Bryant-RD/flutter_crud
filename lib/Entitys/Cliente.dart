class Cliente {
  int id;
  String nombre;
  // Add other properties as needed

  Cliente({required this.id, required this.nombre});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    return data;
  }

  Cliente.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'] {
    id = json['id'];
    nombre = json['nombre'];
  }
}
