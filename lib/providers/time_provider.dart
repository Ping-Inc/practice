import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_provider.g.dart';

@riverpod
Stream<DateTime> time(TimeRef ref) async* {
  yield DateTime.now();

  await for (var _ in Stream.periodic(Duration(seconds: 1))) {
    yield DateTime.now();
  }
}
