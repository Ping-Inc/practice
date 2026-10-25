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
    // Hiding a ping also makes it private.
    await db.rawUpdate(
      hide
          ? 'UPDATE pings SET hidden = 1, public_time = NULL WHERE id = ?'
          : 'UPDATE pings SET hidden = 0 WHERE id = ?',
      [id],
    );
  }

  static Future<void> setPublicTime(int id, DateTime? publicTime) async {
    await db.rawUpdate(
      'UPDATE pings SET public_time = ? WHERE id = ?',
      [publicTime?.millisecondsSinceEpoch, id],
    );
  }
}
