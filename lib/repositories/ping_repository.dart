import 'package:practice/constants.dart';

class PingRepository {
  PingRepository._();

  static Future<void> incrementResonantCount(int id) async {
    await db.rawUpdate(
      'UPDATE pings SET resonant_count = resonant_count + 1, resonant_time = ? WHERE id = ?',
      [DateTime.now().millisecondsSinceEpoch, id],
    );
  }

  static Future<void> toggleVisibility(int id, bool hide) async {
    await db.rawUpdate(
      'UPDATE pings SET hidden = ? WHERE id = ?',
      [hide, id],
    );
  }

  static Future<List<Map<String, Object?>>> fetchReplies(int id) async {
    return db.rawQuery('''
      WITH RECURSIVE
        replies_up AS (
          SELECT * FROM pings WHERE id = ?
          UNION ALL
          SELECT p.* FROM pings p
          INNER JOIN replies_up ru ON p.reply_id = ru.id
          WHERE p.hidden = 0
        ),
        replies_down AS (
          SELECT * FROM pings WHERE id = ?
          UNION ALL
          SELECT p.* FROM pings p
          INNER JOIN replies_down rd ON rd.reply_id = p.id
          WHERE p.hidden = 0
        )
      SELECT DISTINCT * FROM (
        SELECT * FROM replies_up
        UNION
        SELECT * FROM replies_down
      )
      WHERE id != ?
      ORDER BY id DESC
    ''', [id, id, id]);
  }

  static Future<List<Map<String, Object?>>> fetchRepliesBeforeTime(
      int id, DateTime time) async {
    return db.rawQuery('''
      WITH RECURSIVE
        replies_up AS (
          SELECT * FROM pings WHERE id = ? AND time < ?
          UNION ALL
          SELECT p.* FROM pings p
          INNER JOIN replies_up ru ON p.reply_id = ru.id
          WHERE p.hidden = 0 AND p.time < ?
        ),
        replies_down AS (
          SELECT * FROM pings WHERE id = ? AND time < ?
          UNION ALL
          SELECT p.* FROM pings p
          INNER JOIN replies_down rd ON rd.reply_id = p.id
          WHERE p.hidden = 0 AND p.time < ?
        )
      SELECT DISTINCT * FROM (
        SELECT * FROM replies_up
        UNION
        SELECT * FROM replies_down
      )
      WHERE id != ?
      ORDER BY id DESC
    ''', [
      id,
      time.millisecondsSinceEpoch,
      time.millisecondsSinceEpoch,
      id,
      time.millisecondsSinceEpoch,
      time.millisecondsSinceEpoch
    ]);
  }
}
