import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:sqflite/sqflite.dart';

class PingsRepository {
  PingsRepository._();

  static Future<List<Map<String, Object?>>> fetch() async {
    return db.query('pings', orderBy: 'time desc');
  }

  static Future<List<Map<String, Object?>>> search(String search) async {
    return db.query(
      'pings',
      where:
          'text LIKE ? AND hidden = 0', // Assuming the column you want to search is named 'content'
      whereArgs: ['%$search%'],
      orderBy: 'time desc',
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
}
