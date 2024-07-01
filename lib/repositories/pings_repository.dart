import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:sqflite/sqflite.dart';

class PingsRepository {
  PingsRepository._();

  static Future<List<Map<String, Object?>>> fetch() async {
    return db.query('pings', orderBy: 'time desc', limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchBeforeTime(
      DateTime time) async {
    return db.query('pings',
        orderBy: 'time desc',
        where: 'time < ?',
        whereArgs: [time.millisecondsSinceEpoch],
        limit: fetchLimit);
  }

  static Future<int> insert(String pingText, DateTime pingTime) async {
    return await db.insert('pings', {
      'time': pingTime.millisecondsSinceEpoch,
      'text': pingText,
    });
  }

  static Future<void> insertAll(List<Ping> pings) async {
    Batch batch = db.batch();

    for (var ping in pings) {
      batch.insert('pings', ping.toJson());
    }

    await batch.commit(noResult: true);
  }

  static Future<void> delete(int id) async {
    await db.delete('pings', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(Ping ping) async {
    await db
        .update('pings', ping.toJson(), where: 'id = ?', whereArgs: [ping.id]);
  }

  static Future<void> deleteAll() async {
    await db.delete('pings');
  }

  // static Future<void> exportToCsv() async {
  //   final List<Map<String, Object?>> data = await fetch();

  //   List<List<dynamic>> rows = [];

  //   rows.add(data[0].keys.toList());

  //   for (var map in data) {
  //     rows.add(map.values.toList());
  //   }

  //   String csvData = const ListToCsvConverter().convert(rows);

  //   // Get the directory to store the file in
  //   final directory = await getApplicationDocumentsDirectory();

  //   // Create a file in the directory
  //   final File file = File(
  //       '${directory.path}/pings_${DateTime.now().millisecondsSinceEpoch}.csv');

  //   // Write the CSV data to the file
  //   await file.writeAsString(csvData);
  // }
}
