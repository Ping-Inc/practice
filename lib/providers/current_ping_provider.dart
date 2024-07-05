import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_ping_provider.g.dart';

@riverpod
class CurrentPing extends _$CurrentPing {
  @override
  String build() {
    return "";
  }

  void set(String newText) {
    state = newText;
  }

  void reset() {
    state = "";
  }
}
