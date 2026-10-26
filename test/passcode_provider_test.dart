import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/providers/passcode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MemoryStore implements PasscodeStore {
  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String v) async => value = v;

  @override
  Future<void> delete() async => value = null;
}

void main() {
  late _MemoryStore store;
  late ProviderContainer container;

  setUp(() {
    store = _MemoryStore();
    container = ProviderContainer(
        overrides: [passcodeStoreProvider.overrideWithValue(store)]);
  });
  tearDown(() => container.dispose());

  test('no passcode at first; nothing verifies', () async {
    final notifier = container.read(passcodeProvider.notifier);
    await notifier.ready;
    expect(container.read(passcodeProvider), isFalse);
    expect(await notifier.verify('1234'), isFalse);
  });

  test('setting a passcode stores a hash, not the digits', () async {
    final notifier = container.read(passcodeProvider.notifier);
    await notifier.setPasscode('1234');

    expect(container.read(passcodeProvider), isTrue);
    expect(store.value, isNotNull);
    expect(store.value!.contains('1234'), isFalse);
    expect(await notifier.verify('1234'), isTrue);
    expect(await notifier.verify('4321'), isFalse);
  });

  test('changing the passcode replaces the old one', () async {
    final notifier = container.read(passcodeProvider.notifier);
    await notifier.setPasscode('1234');
    await notifier.setPasscode('9876');

    expect(await notifier.verify('9876'), isTrue);
    expect(await notifier.verify('1234'), isFalse);
  });

  test('a passcode already in the store is picked up on start', () async {
    store.value = PasscodeHash.create('2468');
    final fresh = ProviderContainer(
        overrides: [passcodeStoreProvider.overrideWithValue(store)]);
    addTearDown(fresh.dispose);

    await fresh.read(passcodeProvider.notifier).ready;
    expect(fresh.read(passcodeProvider), isTrue);
  });

  test('the same passcode hashes differently each time (salted)', () {
    expect(PasscodeHash.create('1234'), isNot(PasscodeHash.create('1234')));
  });

  group('after a reinstall', () {
    test('an old passcode is cleared on the first launch only', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      store.value = PasscodeHash.create('1234');

      await clearPasscodeIfReinstalled(prefs, store);
      expect(store.value, isNull);

      // Later launches keep a passcode set after that.
      store.value = PasscodeHash.create('5678');
      await clearPasscodeIfReinstalled(prefs, store);
      expect(store.value, isNotNull);
    });
  });
}
