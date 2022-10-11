import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolast/todomodal.dart';

const String columnId = 'id';
const String columnName = 'name';
const String columnDate = 'date';
const String columnIsChecked = 'isChecked';
const String todoTable = 'todo_table';

class DbHelper {
  late Database db;
  static final DbHelper instance = DbHelper._internal();

  factory DbHelper() {
    return instance;
  }
  DbHelper._internal();

  Future opendatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = await join(databasesPath, 'db_todo');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      db.execute(
          'create table $todoTable( $columnId integer primary key autoincrement,$columnName text not null,$columnDate integer not null,$columnIsChecked integer not null)');
    });
  }

  Future<TodoDetails> addtodo(TodoDetails todo) async {
    await db.insert(todoTable, todo.toMap());
    return todo;
  }

  Future<List<TodoDetails>> allTodos() async {
    List<Map<String, dynamic>> todoasmaps = await db.query(todoTable);
    if (todoasmaps.length == 0)
      return [];
    else {
      List<TodoDetails> alltodos = [];
      todoasmaps.forEach((element) {
        alltodos.add(TodoDetails.fromMap(element));
      });
      return alltodos;
    }
  }

  Future<int> removetodo(int id) async {
    return await db.delete(
      todoTable,
      where: 'Id?',
      whereArgs: [id],
    );
  }
}
