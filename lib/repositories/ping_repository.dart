import 'package:practice/constants.dart';
import 'package:sqflite/sqflite.dart';

class PingRepository {
  PingRepository._();

  static Future<void> incrementResonantCount(int id) async {
    await db.rawUpdate(
      'UPDATE pings SET resonant_count = resonant_count + 1 WHERE id = ?',
      [id],
    );
  }

  static Future<void> toggleVisibility(int id, bool hide) async {
    await db.rawUpdate(
      'UPDATE pings SET hidden = ? WHERE id = ?',
      [hide, id],
    );
  }

  static Future<int> countReplies(int id) async {
    final result = await db.rawQuery(
      'SELECT COUNT(id) as count FROM pings WHERE reply_id = ? AND hidden = 0',
      [id],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<List<Map<String, Object?>>> fetchReplies(int id) async {
    return db.query('pings',
        where: 'reply_id = ? AND hidden = 0',
        whereArgs: [id],
        orderBy: 'time desc',
        limit: fetchLimit);
  }

  static Future<List<Map<String, Object?>>> fetchRepliesBeforeTime(
      int id, DateTime time) async {
    return db.query('pings',
        where: 'reply_id = ? AND time < ? AND hidden = 0',
        whereArgs: [id, time.millisecondsSinceEpoch],
        orderBy: 'time desc',
        limit: fetchLimit);
  }
}
