import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:super_list/src/models/product_model.dart';
export 'package:super_list/src/models/product_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'AppDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Products ('
          ' id INTEGER PRIMARY KEY,'
          ' uuid TEXT,'
          ' expected_quantity INTEGER,'
          ' purchased_quantity INTEGER,'
          ' name TEXT,'
          ' description TEXT'
          ')');
    });
  }

  //========================================//
  newProduct(ProductModel newProduct) async {
    final db = await database;
    final res = await db.insert('Products', newProduct.toJson());
    return res;
  }

  Future<ProductModel> getProductById(int id) async {
    final db = await database;
    final res = await db.query('Products', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ProductModel.fromJson(res.first) : null;
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    final res = await db.query('Products');

    List<ProductModel> list =
        res.isNotEmpty ? res.map((c) => ProductModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateProduct(ProductModel product) async {
    final db = await database;
    final res = await db.update('Products', product.toJson(),
        where: 'id = ?', whereArgs: [product.id]);
    return res;
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    final res = await db.delete('Products', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllProducts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Products');
    return res;
  }
}
