import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/providers/derived_pings_providers.dart';
import 'package:practice/providers/homepage_filters_provider.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/providers/scoped_pings_map_provider.dart';
import 'package:practice/providers/simple_saved_searches_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime.now();

PingData ping(int id,
        {bool public = false, bool hidden = false, int resonantCount = 0}) =>
    PingData(
      id: id,
      time: _now.subtract(Duration(days: 30 + id)),
      text: 'ping $id',
      viewCount: 0,
      resonantCount: resonantCount,
      hidden: hidden,
      resonantTime: resonantCount > 0 ? _now : null,
      publicTime: public ? _now : null,
    );

class _FakePingsMap extends PingsMap {
  @override
  Future<Map<int, PingData>> build() async => {
        1: ping(1, public: true),
        2: ping(2, resonantCount: 1), // private, re-pinged
        3: ping(3, public: true, hidden: true), // can't normally happen
        4: ping(4, hidden: true),
      };
}

class _FakeSavedSearches extends SimpleSavedSearches {
  @override
  Future<List<String>> build() async => ['secret'];
}

Future<ProviderContainer> containerIn({required bool publicMode}) async {
  SharedPreferences.setMockInitialValues({
    'public_mode_enabled': true,
    'app_mode_public': publicMode,
  });
  prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(overrides: [
    pingsMapProvider.overrideWith(() => _FakePingsMap()),
    simpleSavedSearchesProvider.overrideWith(() => _FakeSavedSearches()),
  ]);
  addTearDown(container.dispose);
  await container.read(pingsMapProvider.future);
  return container;
}

void main() {
  test('private mode sees every ping', () async {
    final c = await containerIn(publicMode: false);
    expect(c.read(scopedPingsMapProvider).value!.keys, [1, 2, 3, 4]);
  });

  test('public mode sees only public, non-hidden pings', () async {
    final c = await containerIn(publicMode: true);
    expect(c.read(scopedPingsMapProvider).value!.keys, [1]);
    expect(c.read(allPingsProvider).map((p) => p.id), [1]);
    // Ping 2 is re-pinged but private, so re-pings has nothing to show.
    expect(c.read(anyResonatedProvider), isFalse);
  });

  test('public mode lenses leave out hidden, public and saved searches',
      () async {
    final c = await containerIn(publicMode: true);
    final lenses = await c.read(homepageFiltersProvider.future);
    expect(lenses.map((l) => l.filter), [FiltersEnum.all_pings]);
  });

  test('private mode lenses still include them', () async {
    final c = await containerIn(publicMode: false);
    final lenses = await c.read(homepageFiltersProvider.future);
    final filters = lenses.map((l) => l.filter).toList();
    expect(filters, contains(FiltersEnum.hidden));
    expect(filters, contains(FiltersEnum.public));
    expect(filters, contains(FiltersEnum.resonated));
    expect(lenses.where((l) => l.isSavedSearch), isNotEmpty);
  });
}
