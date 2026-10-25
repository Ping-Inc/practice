import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/lens_date.dart';
import 'package:practice/utils/ping_date_utils.dart';

PingData ping(int id, DateTime time,
        {DateTime? rePinged, DateTime? placed, DateTime? madePublic}) =>
    PingData(
      id: id,
      time: time,
      text: 'ping $id',
      viewCount: 0,
      resonantCount: rePinged == null ? 0 : 1,
      hidden: false,
      resonantTime: rePinged,
      placedTime: placed,
      publicTime: madePublic,
    );

void main() {
  final captured = DateTime(2026, 10, 1);
  final later = DateTime(2026, 10, 5);

  test('each lens date reads its own field', () {
    final p = ping(1, captured, rePinged: later, placed: later, madePublic: later);
    expect(LensDate.captured.of(p), captured);
    expect(LensDate.rePinged.of(p), later);
    expect(LensDate.placed.of(p), later);
    expect(LensDate.madePublic.of(p), later);
  });

  test('falls back to the capture date when the field is empty', () {
    final p = ping(1, captured);
    expect(LensDate.rePinged.of(p), captured);
    expect(LensDate.placed.of(p), captured);
    expect(LensDate.madePublic.of(p), captured);
  });

  test('a frozen lens date keeps a ping\'s date after it changes', () {
    final p = ping(1, captured, madePublic: later);
    final frozen = LensDate.madePublic.frozenFor([p]);
    // Made private inside the public lens: it keeps its "made public" date.
    expect(frozen.of(p.copyWith(publicTime: null)), later);
  });

  test('sorting puts the most recent lens date first', () {
    final a = ping(1, DateTime(2026, 10, 1), madePublic: DateTime(2026, 10, 9));
    final b = ping(2, DateTime(2026, 10, 3), madePublic: DateTime(2026, 10, 4));
    final pings = [b, a];
    PingDateUtils.sortPingsByTime(pings, lensDate: LensDate.madePublic);
    expect(pings.map((p) => p.id), [1, 2]);
    PingDateUtils.sortPingsByTime(pings);
    expect(pings.map((p) => p.id), [2, 1]);
  });
}
