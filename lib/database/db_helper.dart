import 'package:rent_a_car_design_four/models/car_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import '../models/user_model.dart';

class DbHelper {
  static const String createTableCar = '''create table $tblCar(
  $tblCarColId integer primary key autoincrement,
  $tblCarColCarModel text,
  $tblCarColCarCategory text,
  $tblCarColCarImage text,
  $tblCarColCarFare integer,
  $tblCarColDriverName text,
  $tblCarColDriverAge integer,
  $tblCarColDriverAddress text,
  $tblCarColDriverPhone integer,
  $tblCarColDriverImage text)''';

  static const String createTableUser = '''create table $tblUser(
  $tblUserColId integer primary key autoincrement,
  $tblUserColEmail text,
  $tblUserColPassword text,
  $tblUserColAdmin integer)''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'car_database');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableCar);
      await db.execute(createTableUser);
    });
  }

  static Future<int> insertCar(CarModel carModel) async {
    final db = await open();
    return db.insert(tblCar, carModel.toMap());
  }

  static Future<List<CarModel>> getAllCars() async {
    final db = await open();
    final mapList = await db.query(tblCar);
    return List.generate(
        mapList.length, (index) => CarModel.fromMap(mapList[index]));
  }

  static Future<CarModel> getCarById(int id) async {
    final db = await open();
    final mapList =
        await db.query(tblCar, where: '$tblCarColId = ?', whereArgs: [id]);
    return CarModel.fromMap(mapList.first);
  }

  static Future<int> deleteCar(int id) async {
    final db = await open();
    return db.delete(tblCar, where: '$tblCarColId = ?', whereArgs: [id]);
  }

  static Future<int> updateCar(CarModel carModel) async {
    final db = await open();
    return db.update(tblCar, carModel.toMap(),
        where: '$tblCarColId = ?', whereArgs: [carModel.id]);
  }

  static Future<int> insertUser(UserModel userModel) async {
    final db = await open();
    return db.insert(tblUser, userModel.toMap());
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final mapList = await db
        .query(tblUser, where: '$tblUserColEmail = ?', whereArgs: [email]);
    if (mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }


  static Future<List<CarModel>> getCarByCategory(String category) async {
    final db = await open();
    final mapList = await db.query(tblCar,
        where: '$tblCarColCarCategory = ?', whereArgs: [category]);
    return List.generate(
        mapList.length, (index) => CarModel.fromMap(mapList[index]));
  }

}
