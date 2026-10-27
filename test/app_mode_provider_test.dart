import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/app_mode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> containerWith(Map<String, Object> saved) async {
  SharedPreferences.setMockInitialValues(saved);
  prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('starts in private mode', () async {
    final c = await containerWith({'public_mode_enabled': true});
    expect(c.read(isPublicModeProvider), isFalse);
  });

  test('entering public mode is saved, so a reopened app stays in it',
      () async {
    final c = await containerWith({'public_mode_enabled': true});
    await c.read(appModeProvider.notifier).enterPublic();
    expect(c.read(isPublicModeProvider), isTrue);

    // A fresh start reads the saved mode.
    final reopened = ProviderContainer();
    addTearDown(reopened.dispose);
    expect(reopened.read(isPublicModeProvider), isTrue);
  });

  test('returning to private mode is saved too', () async {
    final c = await containerWith(
        {'public_mode_enabled': true, 'app_mode_public': true});
    await c.read(appModeProvider.notifier).returnToPrivate();
    expect(c.read(isPublicModeProvider), isFalse);
    expect(prefs.getBool('app_mode_public'), isFalse);
  });

  test('never in public mode while the Dev Settings switch is off', () async {
    final c = await containerWith(
        {'public_mode_enabled': false, 'app_mode_public': true});
    expect(c.read(isPublicModeProvider), isFalse);
  });
}
