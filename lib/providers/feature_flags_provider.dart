import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart' as app_prefs;

// Made this as an enum, so it's easy to expand in the future if needed (e.g., for "production" / "public" builds)
enum ReleaseType {
  internal,
  beta,
}

class FeatureFlags {
  // * CHANGE THIS FOR `internal` vs `beta` (vs `...`) RELEASES *
  static const ReleaseType releaseType = ReleaseType.internal; // TODO: Change to `internal` for internal builds
  
  static bool get showDevSettings {
    switch (releaseType) {
      case ReleaseType.internal:
        return true; // Show "Dev Settings" for internal builds
      default:
        return false; // Do NOT show "Dev Settings" for non-internal builds
    }
  }
  
  // Public mode: used on internal builds until someone sets it in "Dev Settings"
  static const bool defaultPublicModeInternal = false;
  // Public mode: beta builds have no "Dev Settings", so this is the only switch
  static const bool defaultPublicModeBeta = false;
}

final showDevSettingsProvider = Provider<bool>((ref) {
  return FeatureFlags.showDevSettings;
});

// DEV SETTING: Public mode (experimental)
class PublicModeEnabledNotifier extends StateNotifier<bool> {
  // Read synchronously (preferences are loaded before the app starts), so
  // public mode's colors are right from the first frame.
  PublicModeEnabledNotifier() : super(_initialValue);

  static const String _prefsKey = 'public_mode_enabled';

  static bool get _defaultValue {
    switch (FeatureFlags.releaseType) {
      case ReleaseType.internal:
        return FeatureFlags.defaultPublicModeInternal;
      case ReleaseType.beta:
        return FeatureFlags.defaultPublicModeBeta;
    }
  }

  static bool get _initialValue {
    if (FeatureFlags.releaseType != ReleaseType.internal) return _defaultValue;
    return app_prefs.prefs.getBool(_prefsKey) ?? _defaultValue;
  }

  Future<void> toggle() async {
    if (FeatureFlags.releaseType != ReleaseType.internal) return;

    final newValue = !state;
    await app_prefs.prefs.setBool(_prefsKey, newValue);
    state = newValue;
  }
}

final publicModeEnabledProvider =
    StateNotifierProvider<PublicModeEnabledNotifier, bool>((ref) {
  return PublicModeEnabledNotifier();
});
