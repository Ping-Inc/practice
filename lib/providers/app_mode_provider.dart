import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/feature_flags_provider.dart';

const String _prefsKey = 'app_mode_public';

/// Whether public mode was turned on, saved so a closed app reopens in it.
/// Use [isPublicModeProvider] to know whether the app is in public mode.
class AppModeNotifier extends StateNotifier<bool> {
  AppModeNotifier() : super(prefs.getBool(_prefsKey) ?? false);

  Future<void> enterPublic() async {
    await prefs.setBool(_prefsKey, true);
    state = true;
  }

  Future<void> returnToPrivate() async {
    await prefs.setBool(_prefsKey, false);
    state = false;
  }
}

final appModeProvider =
    StateNotifierProvider<AppModeNotifier, bool>((ref) => AppModeNotifier());

/// True when the app is in public mode. Always false if public mode isn't
/// available ([publicModeEnabledProvider]), so turning it off can never leave
/// the app stuck in it.
final isPublicModeProvider = Provider<bool>((ref) {
  return ref.watch(publicModeEnabledProvider) && ref.watch(appModeProvider);
});
