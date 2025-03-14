import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:sqflite/sqflite.dart';

class PingsRepository {
  PingsRepository._();

  static Future<int> viewCount(int pingId) async {
    final result = await db.rawQuery(
      'SELECT view_count FROM pings WHERE id = ?',
      [pingId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<int> repingedCount(int pingId) async {
    final result = await db.rawQuery(
      'SELECT resonant_count FROM pings WHERE id = ?',
      [pingId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<int> count() async {
    final result = await db
        .rawQuery('SELECT COUNT(id) as count FROM pings WHERE hidden = 0');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<Map<String, Object?>>> latest() async {
    return db.query('pings', orderBy: 'time desc', limit: 1);
  }

  static Future<List<Map<String, Object?>>> fetchYears() async {
    return db.rawQuery(
        'SELECT DISTINCT strftime("%Y", time / 1000, "unixepoch", "localtime") as year FROM pings ORDER BY year ASC');
  }

  static Future<List<Map<String, Object?>>> fetchAll() async {
    return db.query('pings', orderBy: 'time desc');
  }

  static Future<List<Map<String, Object?>>> fetchReplies() async {
    return db.query('pings',
        where:
            'id IN (SELECT DISTINCT reply_id FROM pings WHERE reply_id IS NOT NULL) AND hidden = 0',
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchNeverVisited() async {
    return db.query('pings',
        where: 'view_count = 0 AND hidden = 0',
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchLastWeek() async {
    // Calculate the start and end of the last week (Sunday to Saturday)
    final currentDate = DateTime.now();

    DateTime endOfLastWeek =
        currentDate.subtract(Duration(days: currentDate.weekday));
    DateTime startOfLastWeek = endOfLastWeek.subtract(Duration(days: 6));

    return db.query('pings',
        where: 'time >= ? AND time <= ? AND hidden = 0',
        whereArgs: [
          startOfLastWeek.millisecondsSinceEpoch,
          endOfLastWeek.millisecondsSinceEpoch
        ],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<Map<String, Object?>> fetchRandom() async {
    final List<Map<String, Object?>> results = await db.query('pings',
        where: 'hidden = 0', orderBy: 'random()', limit: 1);

    return results.first;
  }

  static Future<List<Map<String, Object?>>> fetchHidden() async {
    return db.query('pings',
        where: 'hidden = 1', orderBy: 'time desc', limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchResonated() async {
    return db.query('pings',
        where: 'resonant_count > 0 AND hidden = 0',
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchDay() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return db.query('pings',
        where: 'time >= ? AND time <= ? AND hidden = 0',
        whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetch() async {
    return db.query('pings',
        orderBy: 'time desc', where: 'hidden = 0', limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchHourRange(
      int startHour, int endHour) async {
    List<Map<String, Object?>> results = [];

    if (startHour > endHour) {
      // Query for hours from startHour to 23:59
      final part1 = await db.query(
        'pings',
        where:
            'strftime("%H", time / 1000, "unixepoch", "localtime") >= ? AND hidden = 0',
        whereArgs: [startHour.toString().padLeft(2, '0')],
        orderBy: 'time desc',
        limit: fetchLimit,
      );

      // Query for hours from 00:00 to endHour
      final part2 = await db.query(
        'pings',
        where:
            'strftime("%H", time / 1000, "unixepoch", "localtime") <= ? AND hidden = 0',
        whereArgs: [endHour.toString().padLeft(2, '0')],
        orderBy: 'time desc',
        limit: fetchLimit,
      );

      results.addAll(part1);
      results.addAll(part2);
    } else {
      // Query for hours within the same day
      results = await db.query(
        'pings',
        where:
            'strftime("%H", time / 1000, "unixepoch", "localtime") BETWEEN ? AND ? AND hidden = 0',
        whereArgs: [
          startHour.toString().padLeft(2, '0'),
          endHour.toString().padLeft(2, '0')
        ],
        orderBy: 'time desc',
        limit: fetchLimit,
      );
    }

    return results;
  }

  static Future<List<Map<String, Object?>>> fetchMonth(
      DateTime monthTime) async {
    final month = monthTime.month;

    return db.query(
      'pings',
      where:
          'strftime("%m", datetime(time / 1000, "unixepoch", "localtime")) = ? AND hidden = 0',
      whereArgs: [month.toString().padLeft(2, '0')],
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchYear(DateTime yearTime) async {
    final startOfYear = DateTime(yearTime.year, 1, 1);
    final endOfYear = DateTime(yearTime.year, 12, 31, 23, 59, 59);

    return db.query(
      'pings',
      where: 'time >= ? AND time <= ? AND hidden = 0',
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
      where:
          'strftime("%w", datetime(time / 1000, "unixepoch", "localtime")) = ? AND hidden = 0',
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
      where:
          'strftime("%d", datetime(time / 1000, "unixepoch", "localtime")) = ? AND hidden = 0',
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
          'text LIKE ? AND hidden = 0', // Assuming the column you want to search is named 'content'
      whereArgs: ['%$search%'],
      orderBy: 'time desc',
      limit: fetchLimit,
    );
  }

  static Future<List<Map<String, Object?>>> fetchBeforeTime(
      DateTime time) async {
    return db.query('pings',
        orderBy: 'time desc',
        where: 'time < ? AND hidden = 0',
        whereArgs: [time.millisecondsSinceEpoch],
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchRepliesBeforeTime(
      DateTime time) async {
    return db.query('pings',
        where:
            'id IN (SELECT DISTINCT reply_id FROM pings WHERE reply_id IS NOT NULL AND time < ?) AND hidden = 0',
        whereArgs: [time.millisecondsSinceEpoch],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchLastWeekBeforeTime(
      DateTime time) async {
    // Calculate the start and end of the last week (Sunday to Saturday)
    final currentDate = DateTime.now();

    DateTime endOfLastWeek =
        currentDate.subtract(Duration(days: currentDate.weekday));
    DateTime startOfLastWeek = endOfLastWeek.subtract(Duration(days: 6));

    return db.query('pings',
        where: 'time >= ? AND time <= ? AND time < ? AND hidden = 0',
        whereArgs: [
          startOfLastWeek.millisecondsSinceEpoch,
          endOfLastWeek.millisecondsSinceEpoch,
          time.millisecondsSinceEpoch
        ],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchNeverVisitedBeforeTime(
      DateTime time) async {
    return db.query('pings',
        where: 'view_count = 0 AND time < ? AND hidden = 0)',
        whereArgs: [time.millisecondsSinceEpoch],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchHiddenBeforeTime(
      DateTime time) async {
    return db.query('pings',
        where: 'hidden = 1 AND time < ?',
        whereArgs: [time.millisecondsSinceEpoch],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchResonatedBeforeTime(
      DateTime time) async {
    return db.query('pings',
        where: 'resonant_count > 0 AND time < ? AND hidden = 0',
        whereArgs: [time.millisecondsSinceEpoch],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchHourRangeBeforeTime(
      DateTime time, int startHour, int endHour) async {
    List<Map<String, Object?>> results = [];

    if (startHour > endHour) {
      // Query for hours from startHour to 23:59
      final part1 = await db.query(
        'pings',
        where:
            'strftime("%H", time / 1000, "unixepoch", "localtime") >= ? AND time < ? AND hidden = 0',
        whereArgs: [
          startHour.toString().padLeft(2, '0'),
          time.millisecondsSinceEpoch
        ],
        orderBy: 'time desc',
        limit: fetchLimit,
      );

      // Query for hours from 00:00 to endHour
      final part2 = await db.query(
        'pings',
        where:
            'strftime("%H", time / 1000, "unixepoch", "localtime") <= ? AND time < ? AND hidden = 0',
        whereArgs: [
          endHour.toString().padLeft(2, '0'),
          time.millisecondsSinceEpoch
        ],
        orderBy: 'time desc',
        limit: fetchLimit,
      );

      results.addAll(part1);
      results.addAll(part2);
    } else {
      // Query for hours within the same day
      results = await db.query(
        'pings',
        where:
            'strftime("%H", time / 1000, "unixepoch", "localtime") BETWEEN ? AND ? AND time < ? AND hidden = 0',
        whereArgs: [
          startHour.toString().padLeft(2, '0'),
          endHour.toString().padLeft(2, '0'),
          time.millisecondsSinceEpoch
        ],
        orderBy: 'time desc',
        limit: fetchLimit,
      );
    }

    return results;
  }

  static Future<List<Map<String, Object?>>> fetchMonthBeforeTime(
      DateTime time, int month) async {
    return db.query(
      'pings',
      where:
          'strftime("%m", datetime(time / 1000, "unixepoch", "localtime")) = ? AND time < ? AND hidden = 0',
      whereArgs: [
        month.toString().padLeft(2, '0'),
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
      where: 'time >= ? AND time <= ? AND time < ? AND hidden = 0',
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
          'strftime("%w", datetime(time / 1000, "unixepoch", "localtime")) = ? AND time < ? AND hidden = 0',
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
          'strftime("%d", datetime(time / 1000, "unixepoch", "localtime")) = ? AND time < ? AND hidden = 0',
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

  static Future<void> insertAll(List<PingData> pings) async {
    Batch batch = db.batch();

    for (var ping in pings) {
      batch.insert('pings', ping.toJson());
    }

    await batch.commit(noResult: true, continueOnError: true);
  }

  static Future<void> delete(int id) async {
    await db.delete('pings', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(PingData ping) async {
    await db
        .update('pings', ping.toJson(), where: 'id = ?', whereArgs: [ping.id]);
  }

  static Future<void> deleteAll() async {
    await db.delete('pings');
  }

  static Future<Map<String, Object?>> random() async {
    final result = await db.query('pings',
        where: 'hidden = 0', orderBy: 'RANDOM()', limit: 1);
    return result.first;
  }

  static Future<void> incrementViewCount(int pingId) async {
    await db.rawUpdate(
      'UPDATE pings SET view_count = view_count + 1 WHERE id = ?',
      [pingId],
    );
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
