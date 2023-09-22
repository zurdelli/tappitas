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
        "CREATE TABLE $tabla (id INTEGER PRIMARY KEY, imagen BLOB, marca TEXT, "
        "fecha TEXT, lugar TEXT, fgColor TEXT, bgColor TEXT, pais TEXT,"
        " tipo TEXT, isFavorited INTEGER, rating REAL, modelo TEXT)",
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
  static Future<List<Tapa>> tapas() async {
    Database db = await _openDB();

    // El query para hacer un select * es simplemente el nombre de la tabla
    final List<Map<String, dynamic>> tapasMap = await db.query(tabla);

    return List.generate(
        tapasMap.length,
        (i) => Tapa(
            id: tapasMap[i]['id'],
            imagen: tapasMap[i]['imagen'],
            marca: tapasMap[i]['marca'],
            fecha: tapasMap[i]['fecha'],
            lugar: tapasMap[i]['lugar'],
            fgColor: tapasMap[i]['fgColor'],
            bgColor: tapasMap[i]['bgColor'],
            pais: tapasMap[i]['pais'],
            tipo: tapasMap[i]['tipo'],
            isFavorited: tapasMap[i]['isFavorited'],
            rating: tapasMap[i]['rating'],
            modelo: tapasMap[i]['modelo']));
  }

  static Future<List<Tapa>> busquedaTapas(
      String marClausula,
      String tipClausula,
      String paiClausula,
      String fgColClausula,
      String bgColClausula) async {
    Database db = await _openDB();

    final List<Map<String, dynamic>> busquedaMap = await db.query(tabla,
        where:
            "marca LIKE ? AND tipo LIKE ? AND pais LIKE ? AND fgColor LIKE ? AND bgColor LIKE ?",
        whereArgs: [
          marClausula,
          tipClausula,
          paiClausula,
          fgColClausula,
          bgColClausula
        ]);

    return List.generate(
        busquedaMap.length,
        (i) => Tapa(
            id: busquedaMap[i]['id'],
            imagen: busquedaMap[i]['imagen'],
            marca: busquedaMap[i]['marca'],
            fecha: busquedaMap[i]['fecha'],
            lugar: busquedaMap[i]['lugar'],
            fgColor: busquedaMap[i]['fgColor'],
            bgColor: busquedaMap[i]['bgColor'],
            pais: busquedaMap[i]['pais'],
            tipo: busquedaMap[i]['tipo'],
            isFavorited: busquedaMap[i]['isFavorited'],
            rating: busquedaMap[i]['rating'],
            modelo: busquedaMap[i]['modelo']));
  }

  static Future<List<Map<String, Object?>>> gimmeSomeData(
      String parameter) async {
    Database db = await _openDB();

    String sentencia =
        "SELECT $parameter, COUNT(*) FROM $tabla GROUP BY $parameter";

    final List<Map<String, Object?>> busquedaMap = await db.rawQuery(sentencia);

    //Map<String, Object?> returnMap = {};

    //int counter = 0;

    // for (var e in busquedaMap) {
    //   returnMap.addAll(e);
    // }

    //print(returnMap);

    return busquedaMap;
  }
}
