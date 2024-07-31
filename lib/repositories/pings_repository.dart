import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:sqflite/sqflite.dart';

class PingsRepository {
  PingsRepository._();

  static Future<int> count() async {
    final result = await db.rawQuery('SELECT COUNT(id) as count FROM pings');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<Map<String, Object?>>> latest() async {
    return db.query('pings', orderBy: 'time desc', limit: 1);
  }

  static Future<List<Map<String, Object?>>> fetchAll() async {
    return db.query('pings', orderBy: 'time desc');
  }

  static Future<List<Map<String, Object?>>> fetchDay() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return db.query(
      'pings',
      where: 'time >= ? AND time <= ?',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
      orderBy: 'time desc',
    );
  }

  static Future<List<Map<String, Object?>>> fetch() async {
    return db.query('pings', orderBy: 'time desc', limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchMonth(
      DateTime monthTime) async {
    final startOfMonth = DateTime(monthTime.year, monthTime.month, 1);
    final endOfMonth =
        DateTime(monthTime.year, monthTime.month + 1, 0, 23, 59, 59);

    return db.query('pings',
        where: 'time >= ? AND time <= ?',
        whereArgs: [
          startOfMonth.millisecondsSinceEpoch,
          endOfMonth.millisecondsSinceEpoch
        ],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchYear(DateTime yearTime) async {
    final startOfYear = DateTime(yearTime.year, 1, 1);
    final endOfYear = DateTime(yearTime.year, 12, 31, 23, 59, 59);

    return db.query(
      'pings',
      where: 'time >= ? AND time <= ?',
      whereArgs: [
        startOfYear.millisecondsSinceEpoch,
        endOfYear.millisecondsSinceEpoch
      ],
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchDayOfWeek(
      DateTime dayOfWeekTime) async {
    final dayOfWeek = dayOfWeekTime.weekday;

    return db.query(
      'pings',
      where: 'strftime("%w", datetime(time / 1000, "unixepoch")) = ?',
      whereArgs: [
        (dayOfWeek % 7).toString()
      ], // SQLite uses 0 for Sunday, 1 for Monday, etc.
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchDayOfMonth(
      DateTime dayOfMonthTime) async {
    final dayOfMonth = dayOfMonthTime.day;

    return db.query(
      'pings',
      where: 'strftime("%d", datetime(time / 1000, "unixepoch")) = ?',
      whereArgs: [
        dayOfMonth.toString().padLeft(2, '0')
      ], // Pad single digits with a leading zero
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> search(String search) async {
    return db.query(
      'pings',
      where:
          'text LIKE ?', // Assuming the column you want to search is named 'content'
      whereArgs: ['%$search%'],
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchBeforeTime(
      DateTime time) async {
    return db.query('pings',
        orderBy: 'time desc',
        where: 'time < ?',
        whereArgs: [time.millisecondsSinceEpoch],
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchMonthBeforeTime(
      DateTime time, DateTime monthTime) async {
    final startOfMonth = DateTime(monthTime.year, monthTime.month, 1);
    final endOfMonth =
        DateTime(monthTime.year, monthTime.month + 1, 0, 23, 59, 59);

    return db.query(
      'pings',
      where: 'time >= ? AND time <= ? AND time < ?',
      whereArgs: [
        startOfMonth.millisecondsSinceEpoch,
        endOfMonth.millisecondsSinceEpoch,
        time.millisecondsSinceEpoch
      ],
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchYearBeforeTime(
      DateTime time, DateTime yearTime) async {
    final startOfYear = DateTime(yearTime.year, 1, 1);
    final endOfYear = DateTime(yearTime.year, 12, 31, 23, 59, 59);

    return db.query(
      'pings',
      where: 'time >= ? AND time <= ? AND time < ?',
      whereArgs: [
        startOfYear.millisecondsSinceEpoch,
        endOfYear.millisecondsSinceEpoch,
        time.millisecondsSinceEpoch
      ],
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchDayOfWeekBeforeTime(
      DateTime time, DateTime dayOfWeekTime) async {
    final dayOfWeek = dayOfWeekTime.weekday;

    return db.query(
      'pings',
      where:
          'strftime("%w", datetime(time / 1000, "unixepoch")) = ? AND time < ?',
      whereArgs: [
        (dayOfWeek % 7).toString(),
        time.millisecondsSinceEpoch
      ], // SQLite uses 0 for Sunday, 1 for Monday, etc.
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchDayOfMonthBeforeTime(
      DateTime time, DateTime dayOfMonthTime) async {
    final dayOfMonth = dayOfMonthTime.day;

    return db.query(
      'pings',
      where:
          'strftime("%d", datetime(time / 1000, "unixepoch")) = ? AND time < ?',
      whereArgs: [
        dayOfMonth.toString().padLeft(2, '0'),
        time.millisecondsSinceEpoch
      ], // Pad single digits with a leading zero
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<int> insert(String pingText, DateTime pingTime) async {
    return await db.insert('pings', {
      'time': pingTime.millisecondsSinceEpoch,
      'text': pingText.trim(),
    });
  }

  static Future<int> insertReply(
      String pingText, int replyId, DateTime pingTime) async {
    return await db.insert('pings', {
      'time': pingTime.millisecondsSinceEpoch,
      'text': pingText.trim(),
      'reply_id': replyId
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

  static Future<Map<String, Object?>> random() async {
    final result = await db.query('pings', orderBy: 'RANDOM()', limit: 1);
    return result.first;
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
