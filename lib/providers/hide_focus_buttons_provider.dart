import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HideFocusButtonsNotifier extends StateNotifier<bool> {
  HideFocusButtonsNotifier() : super(false) {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('hide_grid_buttons') ?? false;
  }

  Future<void> toggle() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state;
    await prefs.setBool('hide_grid_buttons', newValue);
    state = newValue;
  }

  Future<void> setValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hide_focus_buttons', value);
    state = value;
  }
}

final hideFocusButtonsProvider = StateNotifierProvider<HideFocusButtonsNotifier, bool>((ref) {
  return HideFocusButtonsNotifier();
});
