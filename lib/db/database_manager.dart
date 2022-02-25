import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'journal_entry_dto.dart';
import '../models/journal_entry.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String SQL_CREATE_SCHEMA_PATH = 'assets/schema_1.sql.txt';
  static const String SQL_SELECT_QUERY = 'SELECT * FROM journal_entries;';
  static const String SQL_INSERT_QUERY =
      'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?);';

  static late DatabaseManager _instance;

  final Database db;

  // database is required
  DatabaseManager._({required Database database}) : db = database;

  // singleton
  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    String SQL_CREATE_SCHEMA =
        await rootBundle.loadString(SQL_CREATE_SCHEMA_PATH);
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      createTables(db, SQL_CREATE_SCHEMA);
    });
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry(JournalEntryDTO dto) {
    db.transaction((txn) async {
      await txn.rawInsert(
          SQL_INSERT_QUERY, [dto.title, dto.body, dto.rating, dto.datetime]);
    });
  }

  Future<List<JournalEntryDTO>> journalEntries() async {
    List<Map> journalRecords = await db.rawQuery(SQL_SELECT_QUERY);
    final journalEntries = journalRecords.map((record) {
      return JournalEntryDTO(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          datetime: record['date']);
    }).toList();
    return journalEntries;
  }
}
