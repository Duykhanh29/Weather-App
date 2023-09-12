import 'dart:io';

import 'package:flutter_application_1/data/models/local_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SQLiteDatabase {
  static final SQLiteDatabase instance = SQLiteDatabase();
  static Database? _database;
  // ignore: non_constant_identifier_names
  final String table_name = "cityDB";

  final String nameCityRaw = "city";
  final String longitudeRaw = "longitude";
  final String latitudeRaw = "latitude";
  final String idRaw = "id";
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initilizeDB();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "city.db";
    // final path = await getApplicationDocumentsDirectory();
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initilizeDB() async {
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentDirectory.path);
    final path = await fullPath;
    var database = await openDatabase(path, version: 1, onCreate: create);
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await createTable(database);
  Future<void> createTable(Database database) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $table_name ("
        "$idRaw INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$nameCityRaw TEXT,"
        "$longitudeRaw DOUBLE,"
        "$latitudeRaw DOUBLE"
        ")");
  }

  Future<int> insertData(
      {required String city,
      required double latitude,
      required double longitude}) async {
    final db = await instance.database;

    // var result = await db.rawInsert(
    //     "INSERT INTO $table_name (null,$nameCityRaw,$longitudeRaw,$latitudeRaw)"
    //     " VALUES (?,?,?)",
    //     [city, longitude, latitude],);
    var result = await db.insert(table_name,
        {nameCityRaw: city, longitudeRaw: longitude, latitudeRaw: latitude},
        nullColumnHack: idRaw);
    return result;
  }

  Future<int> updateData(
      {required String city,
      required double latitude,
      required double longitude,
      required int id}) async {
    var result = await _database!.update(table_name,
        {nameCityRaw: city, latitudeRaw: latitude, longitudeRaw: longitude},
        where: '$idRaw=?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.rollback);
    return result;
  }

  Future<List<LocalData>?> fetchAllData() async {
    final db = await instance.database;
    final data = await db.rawQuery("SELECT * FROM $table_name");
    return data.map((e) => LocalData.fromJson(e)).toList();
  }

  Future<LocalData>? fetchDataByID(int id) async {
    final data = await _database!
        .rawQuery("SELECT * FROM $table_name WHERE $idRaw = ?", [id]);
    return LocalData.fromJson(data.first);
  }

  Future<int> deleteData(int id) async {
    var result = await _database!
        .delete(table_name, where: "$idRaw =?", whereArgs: [id]);
    // return result;
    return await _database!
        .rawDelete("DELETE FROM $table_name WHERE $idRaw = ? ", [id]);
  }

  Future<int> deleteDataWithParams(
      {required String cityName,
      required double longitude,
      required double latitude}) async {
    var result = await _database!.delete(table_name,
        where: '$nameCityRaw= ? AND $longitudeRaw = ? AND $latitudeRaw = ?',
        whereArgs: [cityName, longitude, latitude]);
    return result;
  }

  // query
  Future<List<String>> getListCityInLocalData(List<LocalData> listData) async {
    var query = await _database!.query(table_name, columns: [nameCityRaw]);
    List<String> list = query.map((e) => e[nameCityRaw].toString()).toList();
    return list;
  }

  Future<LocalData> getLocalDataByParams(
      String city, double longitude, double latitude) async {
    final sql = _database!.query(table_name,
        where: '$nameCityRaw = ? AND $longitudeRaw = ? AND $latitudeRaw = ?',
        whereArgs: [city, longitude, latitude],
        limit: 1) as List<Map<String, dynamic>>;
    Map<String, dynamic> data = sql.first;
    return LocalData.fromJson(data);
  }

  // searchHistory TABLE
}
