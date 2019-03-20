import 'package:sqflite/sqflite.dart' as sql;
//https://juejin.im/post/5bf13747e51d4552ee424078

class Todo {
  static const columnId = "id";
  static const columnTitle = "title";
  static const columnContent = "content";
  int id;

  String title;
  String content;

  Todo(this.title, this.content, [this.id]);

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    content = map[columnContent];
  }

  Map<String, dynamic> toMap() {
    return {columnContent: content, columnTitle: title};
  }

  @override
  String toString() {
    return 'Todo{id=$id, title=$title, content=$content}';
  }
}

void testSql() async {
  const table = 'Todo';
  var path = await sql.getDatabasesPath() + '/demo.db';
  print(">>>>>>"+path);
  var database =
      await sql.openDatabase(path, version: 1, onCreate: (db, version) async {
    var createSql = '''
    CREATE TABLE $table(
    '${Todo.columnId}' INTEGER PRIMARY KEY,
    '${Todo.columnTitle}' TEXT,
    '${Todo.columnContent}' TEXT
    )
    ''';
    print(">>>>>>"+createSql);
    await db.execute(createSql);
//    print(await db.query(table));
  });

  //清除表中所有数据
  await database.delete(table);

  var todo1 = Todo('Flutter', 'Learn Flutter widgets.');
  var todo2 = Todo('Flutter', 'Learn how to to IO in Flutter.');

  //insert
  await database.insert(table, todo1.toMap());
  await database.insert(table, todo2.toMap());

  //query
  List<Map> list = await database.query(table);
  print(list);
  todo1.content += 'Come on!';
  todo2.content += " I am tried";

  //事务
  await database.transaction((tx) async {
    await tx.update(table, todo1.toMap(),
        where: "${Todo.columnId} = ?", whereArgs: [todo1.id]);
    await tx.update(table, todo2.toMap(),
        where: "${Todo.columnId} = ?", whereArgs: [todo2.id]);
  });

  list = await database.query(table);

  for (var map in list) {
    var todo = Todo.fromMap(map);
    print('updated: todo = $todo');
  }

  await database.close();
}

void main() async {
    testSql();
}
//
////class BtnWidget
