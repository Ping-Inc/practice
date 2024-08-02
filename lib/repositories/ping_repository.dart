import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:sqflite/sqflite.dart';

class PingRepository {
  PingRepository._();

  static Future<void> incrementResonantCount(int id) async {
    await db.rawUpdate(
      'UPDATE pings SET resonant_count = resonant_count + 1 WHERE id = ?',
      [id],
    );
  }
}
