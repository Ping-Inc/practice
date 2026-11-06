import 'package:flutter_riverpod/flutter_riverpod.dart';

// Made this as an enum, so it's easy to expand in the future if needed (e.g., for "production" / "public" builds)
enum ReleaseType {
  internal,
  beta,
}

class FeatureFlags {
  // * CHANGE THIS FOR `internal` vs `beta` (vs `...`) RELEASES *
  static const ReleaseType releaseType = ReleaseType.beta; // TODO: Change to `internal` for internal builds
  
  static bool get showDevSettings {
    switch (releaseType) {
      case ReleaseType.internal:
        return true; // Show "Dev Settings" for internal builds
      default:
        return false; // Do NOT show "Dev Settings" for non-internal builds
    }
  }
}

final showDevSettingsProvider = Provider<bool>((ref) {
  return FeatureFlags.showDevSettings;
});

/// Whether public mode is available. It's on for everyone.
///
/// Every part of public mode checks this, so it's the one place to change if
/// people can opt out later, or if public mode is turned off. When it's false
/// the app is never in public mode and the public buttons are hidden.
///
/// The old "public_mode_enabled" preference from the Dev Settings switch is
/// deliberately ignored: testers who turned the experiment off still have
/// `false` saved. An opt-out should use a new preference.
final publicModeEnabledProvider = Provider<bool>((ref) => true);
