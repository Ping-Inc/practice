import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/pings_map_provider.dart';

PingData ping(int id, {DateTime? madePublic, bool hidden = false}) => PingData(
      id: id,
      time: DateTime(2026, 10, 1),
      text: 'ping $id',
      viewCount: 0,
      resonantCount: 0,
      hidden: hidden,
      resonantTime: null,
      publicTime: madePublic,
    );

class _FakePingsMap extends PingsMap {
  _FakePingsMap(this.pings);

  final List<PingData> pings;

  @override
  Future<Map<int, PingData>> build() async =>
      {for (final p in pings) p.id!: p};
}

void main() {
  test('public pings: only public, not hidden, most recently made public first',
      () async {
    final container = ProviderContainer(overrides: [
      pingsMapProvider.overrideWith(() => _FakePingsMap([
            ping(1, madePublic: DateTime(2026, 10, 3)),
            ping(2),
            ping(3, madePublic: DateTime(2026, 10, 5)),
            // Can't normally happen (hiding makes a ping private), but
            // shouldn't be counted if it does.
            ping(4, madePublic: DateTime(2026, 10, 6), hidden: true),
          ])),
    ]);
    addTearDown(container.dispose);

    await container.read(pingsMapProvider.future);
    final publicPings = container.read(publicPingsProvider);

    expect(publicPings.map((p) => p.id), [3, 1]);
    expect(container.read(anyPublicProvider), isTrue);
  });
}
