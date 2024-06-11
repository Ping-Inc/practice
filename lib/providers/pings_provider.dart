import 'dart:async';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pings_provider.g.dart';

@riverpod
class Pings extends _$Pings {
  @override
  Future<List<Ping>> build() async {
    final pingMaps = await db.query('pings');

    return pingMaps.map<Ping>((data) => Ping.fromJson(data)).toList();
  }

  void addPing() async {
    final ping = Ping(time: DateTime.now(), text: 'Ping');

    await db.insert(
      'pings',
      ping.toJson(),
    );

    final pings = await future;

    pings.insert(0, ping);

    state = AsyncData(pings);
  }

  void addPings(List<Map<String, dynamic>> pings) async {
    // await db.batch(
    //   'pings',
    //   pings,
    // );

    // final newPings = await future;

    // newPings.insertAll(0, pings.map((ping) => Ping.fromJson(ping)));

    // state = AsyncData(newPings);
  }
}
