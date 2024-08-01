import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reply_on_provider.g.dart';

@riverpod
class ReplyOn extends _$ReplyOn {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void reset() {
    state = false;
  }
}
