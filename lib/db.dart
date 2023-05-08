import 'package:tappitas/models/tapa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase que gestiona la database. Funciona bajo SQLite
class DB {
  /// Crea o abre la database "tapitas.db"
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'tapitas.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE tapitas (id INTEGER PRIMARY KEY, imagen BLOB, marca TEXT, nombre TEXT, "
        "fecha TEXT, lugar TEXT, color TEXT, pais TEXT, tipo TEXT)",
      );
    }, version: 1);
  }

  static Future<void> insert(Tapa tapa) async {
    Database db = await _openDB();

    /// Para insertar se debe convertir el objeto a un mapa
    await db.insert(
      'tapitas',
      tapa.toMap(),
      // Por si el objeto ya existe en la ddbb
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(Tapa tapa) async {
    Database db = await _openDB();

    await db.delete('tapitas', where: "id = ?", whereArgs: [tapa.id]);
  }

  static Future<void> update(Tapa tapa) async {
    Database database = await _openDB();

    await database
        .update('tapitas', tapa.toMap(), where: "id = ?", whereArgs: [tapa.id]);
  }

  ///Genera una lista de tapas
  static Future<List<Tapa>> tapas() async {
    Database db = await _openDB();

    // El query para hacer un select * es simplemente el nombre de la tabla
    final List<Map<String, dynamic>> tapasMap = await db.query('tapitas');

    return List.generate(
        tapasMap.length,
        (i) => Tapa(
            id: tapasMap[i]['id'],
            imagen: tapasMap[i]['imagen'],
            marca: tapasMap[i]['marca'],
            color: tapasMap[i]['color'],
            fecha: tapasMap[i]['fecha'],
            lugar: tapasMap[i]['lugar'],
            nombre: tapasMap[i]['nombre'],
            pais: tapasMap[i]['pais'],
            tipo: tapasMap[i]['tipo']));
  }
}
