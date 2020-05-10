import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/account.dart';

class DbProvider {
  Database _database;

  void dispose() {
    _database?.close();
    _database = null;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initialize();
    }

    return _database;
  }

  Future<Database> _initialize() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'spend_tracker.db');

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Account ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "codePoint INTEGER,"
        "balance REAL"
        ")");
  }

  Future<int> createAccount(Account account) async {
    final db = await database;

    return await db.insert('Account', account.toMap());
  }

  Future<int> updateAccount(Account account) async {
    final db = await database;

    return await db.update(
      'Account',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<List<Account>> getAllAccounts() async {
    final db = await database;
    final result = await db.query('Account');

    List<Account> list = result.isNotEmpty
        ? result.map((data) => Account.fromMap(data)).toList()
        : [];

    return list;
  }
}
