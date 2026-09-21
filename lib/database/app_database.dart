import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AppDatabase {
  static final AppDatabase instance =
      AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    late String path;

    if (kIsWeb) {
      databaseFactory =
          databaseFactoryFfiWeb;

      path = 'partida.db';
    } else if (Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      path = 'partida.db';
    } else {
      final databasePath =
          await getDatabasesPath();

      path = join(
        databasePath,
        'partida.db',
      );
    }

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE partidas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rodada INTEGER NOT NULL,
        data TEXT NOT NULL,
        timeCasa TEXT NOT NULL,
        timeVisitante TEXT NOT NULL,
        golsCasa INTEGER NOT NULL,
        golsVisitante INTEGER NOT NULL
      )
    ''');
  }
}