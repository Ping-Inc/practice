import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/ping_data.dart';

void main() {
  final captured = DateTime(2026, 10, 1, 9, 0);
  final ping = PingData(
    id: 1,
    time: captured,
    text: 'hello',
    viewCount: 0,
    resonantCount: 0,
    hidden: false,
    resonantTime: null,
  );

  test('a ping can be made public once it is 24 hours old', () {
    expect(ping.canBePublic(captured.add(const Duration(hours: 23, minutes: 59))), isFalse);
    expect(ping.canBePublic(captured.add(const Duration(hours: 24))), isTrue);
  });

  test('isPublic follows publicTime', () {
    expect(ping.isPublic, isFalse);
    expect(ping.copyWith(publicTime: DateTime(2026, 10, 3)).isPublic, isTrue);
  });

  test('public_time round-trips through JSON', () {
    final madePublic = DateTime(2026, 10, 3, 12, 30);
    final json = ping.copyWith(publicTime: madePublic).toJson();
    expect(json['public_time'], madePublic.millisecondsSinceEpoch);
    expect(PingData.fromJson(json).publicTime, madePublic);
    expect(PingData.fromJson(ping.toJson()).publicTime, isNull);
  });
}
