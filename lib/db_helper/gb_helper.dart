import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:todoapp/models/task.dart';

class DbHelper {


  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'tasks.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE todo_tasks(id INTEGER PRIMARY KEY,name TEXT,category TEXT,time TEXT,done INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(TaskItem taskItem) async {
    final sql.Database db = await DbHelper.database();
    db.insert(
      'todo_tasks',
      taskItem.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
  static Future<List<Map<String,dynamic>>> getData()async {
    final db = await DbHelper.database();
    return await db.query('todo_tasks');
  }
  static Future<int> delete(TaskItem taskItem)async{
    final db = await DbHelper.database();
    return  db.delete('todo_tasks',where: 'id = ?', whereArgs: [taskItem.id]);
  }
  static Future<int> update(TaskItem taskItem)async{
    final db = await DbHelper.database();
    return await db.update('todo_tasks',
      taskItem.toMap(),
    where: 'id = ?', whereArgs: [taskItem.id]);
  }
}
