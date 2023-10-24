/// Model of tappa
class Tapa {
  int? id;
  late String imagen;
  late String brewery;
  late String brewCountry;
  late String brewCountryCode;
  late String date;
  late String place;
  late String primColor;
  late String secoColor;
  late String type;
  late int isFavorited;
  late double rating;
  late String model;

  Tapa(
      {this.id,
      required this.imagen,
      required this.brewery,
      required this.brewCountry,
      required this.brewCountryCode,
      required this.primColor,
      required this.secoColor,
      required this.date,
      required this.place,
      required this.type,
      required this.isFavorited,
      required this.rating,
      required this.model});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagen': imagen,
      'brewery': brewery,
      'brewCountry': brewCountry,
      'brewCountryCode': brewCountryCode,
      'date': date.toString(),
      'place': place,
      'primColor': primColor,
      'secoColor': secoColor,
      'type': type,
      'isFavorited': isFavorited,
      'rating': rating,
      'model': model
    };
  }

  @override
  String toString() {
    return 'Tapa{id: $id, tipo: $type, marca: $brewery}';
  }
}
