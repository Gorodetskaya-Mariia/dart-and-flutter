import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db; //from package:sqflite/sqflite.dart, it is a link to database

  init() async {
    Directory documentsDirectory =
        await getApplicationDocumentsDirectory(); //reference to the directory where we store files
    final path =
        join(documentsDirectory.path, "items.db"); //reference to the db
    db = await openDatabase(
        //open existing db or create new db by onCreate method
        path,
        version: 1, onCreate: (Database newDb, int version) {
      newDb.execute("""
            CREATE TABLE Items (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
          """);
    });
  }

  fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns:
          null, //null because we want to fetch entire table not just specific columns
      where: "id = ?", //search criterion
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromJson(maps.first);
    }

    return null;
  }

  addItem(ItemModel item) {
    return db.insert("Items", item.toMapForDb());
  }
}
