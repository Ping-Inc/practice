import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedSearchSettingNotifier extends StateNotifier<bool> {
  CachedSearchSettingNotifier() : super(false) {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('cached_search_enabled') ?? false;
  }

  Future<void> setSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cached_search_enabled', value);
    state = value;
  }

  Future<void> toggle() async {
    await setSetting(!state);
  }
}

final cachedSearchSettingProvider = StateNotifierProvider<CachedSearchSettingNotifier, bool>(
  (ref) => CachedSearchSettingNotifier(),
);
