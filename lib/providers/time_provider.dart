import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_provider.g.dart';

@riverpod
Stream<DateTime> time(Ref ref) async* {
  yield DateTime.now();

  await for (var _ in Stream.periodic(Duration(minutes: 1))) {
    yield DateTime.now();
  }
}
