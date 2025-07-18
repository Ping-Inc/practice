import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice/components/settings_activation_cell.dart';

class CircularGestureActivationCell extends StatefulWidget {
  const CircularGestureActivationCell({super.key});

  @override
  _CircularGestureActivationCellState createState() => _CircularGestureActivationCellState();
}

class _CircularGestureActivationCellState extends State<CircularGestureActivationCell> {
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSetting();
  }

  _loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEnabled = prefs.getBool('circular_gesture_enabled') ?? false;
    });
  }

  _saveSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('circular_gesture_enabled', value);
    setState(() {
      _isEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsActivationCell(
      text: _isEnabled ? 'Switch back to horizontal swipes' : 'Try out circular gesture recognizer',
      onTap: () {
        _saveSetting(!_isEnabled);
      },
    );
  }
}
