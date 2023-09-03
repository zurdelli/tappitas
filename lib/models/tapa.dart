/// Modelo de la tapa
class Tapa {
  int? id;
  late String imagen;
  String marca;
  late String nombre;
  late String fecha;
  late String lugar;
  late String color;
  late String pais;
  late String tipo;

  //Tapa(this.id, this.marca);

  Tapa({
    this.id,
    required this.imagen,
    required this.marca,
    required this.color,
    required this.fecha,
    required this.lugar,
    required this.nombre,
    required this.pais,
    required this.tipo,
  });

  // @override
  // int get hashCode => id;

  // @override
  // bool operator ==(Object other) => other is Tapa && other.id == id;

  // String get marca => marca;
  // String get nombre => nombre;
  // DateTime get fecha => fecha;
  // String get lugar => lugar;
  // String get color => color;
  // String get pais => pais;
  // String get tipo => tipo;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagen': imagen,
      'marca': marca,
      'nombre': nombre,
      'fecha': fecha.toString(),
      'lugar': lugar,
      'color': color,
      'pais': pais,
      'tipo': tipo,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Tapa{id: $id, name: $nombre, marca: $marca}';
  }
}
