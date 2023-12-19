import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact Text,description TEXT);";
    await database.execute(sql);
  }

  Future<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion == 2) {
      String addColumnSql = "ALTER TABLE users ADD COLUMN address TEXT;";
      await database.execute(addColumnSql);
    }
  }
}
