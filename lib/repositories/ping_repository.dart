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
      'SELECT COUNT(id) as count FROM pings WHERE reply_id = ?',
      [id],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
