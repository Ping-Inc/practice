import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/app_mode_provider.dart';
import 'package:practice/providers/feature_flags_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> containerWith(Map<String, Object> saved,
    {List<Override> overrides = const []}) async {
  SharedPreferences.setMockInitialValues(saved);
  prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(overrides: overrides);
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('starts in private mode', () async {
    final c = await containerWith({});
    expect(c.read(isPublicModeProvider), isFalse);
  });

  test('entering public mode is saved, so a reopened app stays in it',
      () async {
    final c = await containerWith({});
    await c.read(appModeProvider.notifier).enterPublic();
    expect(c.read(isPublicModeProvider), isTrue);

    // A fresh start reads the saved mode.
    final reopened = ProviderContainer();
    addTearDown(reopened.dispose);
    expect(reopened.read(isPublicModeProvider), isTrue);
  });

  test('returning to private mode is saved too', () async {
    final c = await containerWith({'app_mode_public': true});
    await c.read(appModeProvider.notifier).returnToPrivate();
    expect(c.read(isPublicModeProvider), isFalse);
    expect(prefs.getBool('app_mode_public'), isFalse);
  });

  test('public mode is available even if the old Dev Settings switch was off',
      () async {
    final c = await containerWith(
        {'public_mode_enabled': false, 'app_mode_public': true});
    expect(c.read(publicModeEnabledProvider), isTrue);
    expect(c.read(isPublicModeProvider), isTrue);
  });

  test('never in public mode while public mode is unavailable', () async {
    final c = await containerWith({'app_mode_public': true},
        overrides: [publicModeEnabledProvider.overrideWithValue(false)]);
    expect(c.read(isPublicModeProvider), isFalse);
  });
}
