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
}
