import 'package:isar/isar.dart';
part 'tapa.g.dart';

/// Model of tappa

@collection
class Tapa {
  Id id = Isar.autoIncrement;
  String? imagen;
  String? brewery;
  String? brewCountry;
  String? brewCountryCode;
  String? date;
  String? place;
  String? primColor;
  String? secoColor;
  String? type;
  int? isFavorited;
  double? rating;
  String? model;

  Tapa(
      {this.imagen,
      this.brewery,
      this.brewCountry,
      this.brewCountryCode,
      this.primColor,
      this.secoColor,
      this.date,
      this.place,
      this.type,
      this.isFavorited,
      this.rating,
      this.model});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'imagen': imagen,
  //     'brewery': brewery,
  //     'brewCountry': brewCountry,
  //     'brewCountryCode': brewCountryCode,
  //     'date': date.toString(),
  //     'place': place,
  //     'primColor': primColor,
  //     'secoColor': secoColor,
  //     'type': type,
  //     'isFavorited': isFavorited,
  //     'rating': rating,
  //     'model': model
  //   };
  // }

  @override
  String toString() {
    return 'Tapa{id: $id, tipo: $type, marca: $brewery}';
  }
}
