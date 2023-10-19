import 'package:tappitas/models/tapa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase que gestiona la database. Funciona bajo SQLite
class DB {
  static String tabla = 'tapitas';

  /// Crea o abre la database "tapitas.db"
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), '$tabla.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE $tabla (id INTEGER PRIMARY KEY, imagen BLOB, brewery TEXT, "
        "date TEXT, place TEXT, primColor TEXT, secoColor TEXT, brewCountry TEXT,"
        "brewCountryCode TEXT, type TEXT, isFavorited INTEGER, rating REAL, model TEXT)",
      );
    }, version: 1);
  }

  static Future<void> insert(Tapa tapa) async {
    Database db = await _openDB();

    /// Para insertar se debe convertir el objeto a un mapa
    await db.insert(
      tabla,
      tapa.toMap(),
      // Por si el objeto ya existe en la ddbb
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(Tapa tapa) async {
    Database db = await _openDB();

    await db.delete(tabla, where: "id = ?", whereArgs: [tapa.id]);
  }

  static Future<void> update(Tapa tapa) async {
    Database database = await _openDB();

    await database
        .update(tabla, tapa.toMap(), where: "id = ?", whereArgs: [tapa.id]);
  }

  /// Solo actualiza si es fav o no
  static Future<void> updateFavorite(int newFavorite, int? id) async {
    Database database = await _openDB();

    await database.rawUpdate(
        'UPDATE $tabla SET isFavorited = ? WHERE id = ?', [newFavorite, id]);
  }

  ///Genera una lista de tapas
  static Future<List<Tapa>> tapas(String order) async {
    Database db = await _openDB();

    // El query para hacer un select * es simplemente el nombre de la tabla
    final List<Map<String, dynamic>> tapasMap =
        await db.query(tabla, orderBy: order);

    return List.generate(
        tapasMap.length,
        (i) => Tapa(
            id: tapasMap[i]['id'],
            imagen: tapasMap[i]['imagen'],
            brewery: tapasMap[i]['brewery'],
            date: tapasMap[i]['date'],
            place: tapasMap[i]['place'],
            primColor: tapasMap[i]['primColor'],
            secoColor: tapasMap[i]['secoColor'],
            brewCountry: tapasMap[i]['brewCountry'],
            brewCountryCode: tapasMap[i]['brewCountryCode'],
            type: tapasMap[i]['type'],
            isFavorited: tapasMap[i]['isFavorited'],
            rating: tapasMap[i]['rating'],
            model: tapasMap[i]['model']));
  }

  static Future<List<Tapa>> busquedaTapas(
      String marClausula,
      String paiClausula,
      String tipClausula,
      String datClausula,
      String plaClausula,
      String fgColClausula,
      String bgColClausula) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> busquedaMap = await db.query(tabla,
        where:
            "brewery LIKE ? AND brewCountry LIKE ? AND type LIKE ? AND date LIKE ? AND place LIKE ? AND primColor LIKE ? AND secoColor LIKE ?",
        whereArgs: [
          marClausula,
          paiClausula,
          tipClausula,
          datClausula,
          plaClausula,
          fgColClausula,
          bgColClausula
        ]);

    return List.generate(
        busquedaMap.length,
        (i) => Tapa(
            id: busquedaMap[i]['id'],
            imagen: busquedaMap[i]['imagen'],
            brewery: busquedaMap[i]['brewery'],
            date: busquedaMap[i]['date'],
            place: busquedaMap[i]['place'],
            primColor: busquedaMap[i]['primColor'],
            secoColor: busquedaMap[i]['secoColor'],
            brewCountry: busquedaMap[i]['brewCountry'],
            brewCountryCode: busquedaMap[i]['brewCountryCode'],
            type: busquedaMap[i]['type'],
            isFavorited: busquedaMap[i]['isFavorited'],
            rating: busquedaMap[i]['rating'],
            model: busquedaMap[i]['model']));
  }

  static Future<List<Map<String, Object?>>> gimmeSomeData(
      String parameter) async {
    Database db = await _openDB();

    String sentencia =
        "SELECT $parameter, COUNT(*) FROM $tabla GROUP BY $parameter";

    final List<Map<String, Object?>> busquedaMap = await db.rawQuery(sentencia);

    return busquedaMap;
  }
}
