import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Where the passcode hash is kept. The real one is the iOS Keychain; tests
/// use an in-memory stand-in.
abstract class PasscodeStore {
  Future<String?> read();
  Future<void> write(String value);
  Future<void> delete();
}

class KeychainPasscodeStore implements PasscodeStore {
  static const _key = 'public_mode_passcode';
  static const _storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      // Only on this device (never synced or restored to another), and
      // readable once the phone has been unlocked after a restart.
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  @override
  Future<String?> read() => _storage.read(key: _key);

  @override
  Future<void> write(String value) => _storage.write(key: _key, value: value);

  @override
  Future<void> delete() => _storage.delete(key: _key);
}

/// The passcode is stored as "salt:hash", never as the digits themselves.
class PasscodeHash {
  PasscodeHash._();

  static String create(String passcode, {Random? random}) {
    final rng = random ?? Random.secure();
    final salt = base64Url.encode(List<int>.generate(16, (_) => rng.nextInt(256)));
    return '$salt:${_hash(salt, passcode)}';
  }

  static bool matches(String stored, String passcode) {
    final parts = stored.split(':');
    if (parts.length != 2) return false;
    return _equals(_hash(parts[0], passcode), parts[1]);
  }

  static String _hash(String salt, String passcode) =>
      sha256.convert(utf8.encode('$salt$passcode')).toString();

  // Compares every character, so a check takes the same time either way.
  static bool _equals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}

final passcodeStoreProvider =
    Provider<PasscodeStore>((ref) => KeychainPasscodeStore());

/// Whether a passcode is set (state), plus setting and checking it.
class PasscodeNotifier extends StateNotifier<bool> {
  PasscodeNotifier(this._store) : super(false) {
    ready = _load();
  }

  final PasscodeStore _store;

  /// Completes once we know whether a passcode is set.
  late final Future<void> ready;

  Future<void> _load() async {
    final stored = await _store.read();
    if (mounted) state = stored != null;
  }

  /// Sets the passcode, replacing any existing one.
  Future<void> setPasscode(String passcode) async {
    await _store.write(PasscodeHash.create(passcode));
    state = true;
  }

  Future<bool> verify(String passcode) async {
    final stored = await _store.read();
    return stored != null && PasscodeHash.matches(stored, passcode);
  }
}

final passcodeProvider = StateNotifierProvider<PasscodeNotifier, bool>((ref) {
  return PasscodeNotifier(ref.watch(passcodeStoreProvider));
});

/// iOS keeps Keychain items after the app is deleted, but not the app's
/// preferences. So if the preferences don't know about this install yet,
/// it's a fresh install (or a reinstall): forget any old passcode.
Future<void> clearPasscodeIfReinstalled(
    SharedPreferences prefs, PasscodeStore store) async {
  const marker = 'passcode_install_seen';
  if (prefs.getBool(marker) == true) return;
  try {
    await store.delete();
  } catch (_) {
    // Nothing to clear, or the Keychain isn't reachable yet; try next launch.
    return;
  }
  await prefs.setBool(marker, true);
}
