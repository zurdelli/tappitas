/// Modelo de la tapa
class Tapa {
  int? id;
  late String imagen;
  late String marca;
  late String fecha;
  late String lugar;
  late String fgColor;
  late String bgColor;
  late String pais;
  late String tipo;
  late int isFavorited;
  late double rating;
  late String modelo;

  Tapa(
      {this.id,
      required this.imagen,
      required this.marca,
      required this.fgColor,
      required this.bgColor,
      required this.fecha,
      required this.lugar,
      required this.pais,
      required this.tipo,
      required this.isFavorited,
      required this.rating,
      required this.modelo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagen': imagen,
      'marca': marca,
      'fecha': fecha.toString(),
      'lugar': lugar,
      'fgColor': fgColor,
      'bgColor': bgColor,
      'pais': pais,
      'tipo': tipo,
      'isFavorited': isFavorited,
      'rating': rating,
      'modelo': modelo
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Tapa{id: $id, tipo: $tipo, marca: $marca}';
  }
}
