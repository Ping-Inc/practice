import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class SystemSwitch extends StatelessWidget {
  const SystemSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      inactiveThumbColor: themeUIBackgroundBlue,
      inactiveTrackColor: themeGray,
      trackOutlineWidth: WidgetStateProperty.all(0.0),
      value: value,
      onChanged: onChanged,
    );
  }
}
