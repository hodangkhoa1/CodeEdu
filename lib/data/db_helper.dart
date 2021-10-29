// import 'package:code_edu/model/task.dart';
// import 'package:sqflite/sqflite.dart';

// class DBHelper {
//   static Database _database;
//   static final int _version = 1;
//   static final String _tableName = "tasks";

//   static Future<void> initDb() async {
//     if(_database != null) {
//       return;
//     }
//     try {
//       String _path = await getDatabasesPath() + "tasks.db";
//       _database = await openDatabase(
//         _path,
//         version: _version,
//         onCreate: (db, version) {
//           return db.execute(
//             "CREATE TABLE $_tableName("
//               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//               "title STRING, note TEXT, date STRING, "
//               "startTime STRING, endTime STRING, "
//               "remind INTEGER, repeat STRING, "
//               "color INTEGER, "
//               "isCompleted INTEGER)",
//           );
//         }
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   static Future<int> insert(Task task) async {
//     return await _database.insert(_tableName, task.toMap()) ?? 1;
//   }
// }