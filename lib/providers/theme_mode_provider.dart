import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/extensions/date_time_enum_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

@riverpod
Stream<ThemeModeEnum> themeMode(ThemeModeRef ref) async* {
  yield DateTime.now().themeMode();

  await for (var _ in Stream.periodic(Duration(seconds: 1))) {
    yield DateTime.now().themeMode();
    ;
  }
}
