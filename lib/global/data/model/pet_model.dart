class PetModel {
  final int id;
  final String nombre;
  final String tipo;
  final int vacunado;
  final int edad;

  PetModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.vacunado,
    required this.edad,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      vacunado: json['vacunado'],
      edad: json['edad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'vacunado': vacunado,
      'edad': edad,
    };
  }
}
