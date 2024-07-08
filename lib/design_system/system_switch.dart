import 'package:flutter/cupertino.dart';

class SystemSwitch extends StatelessWidget {
  const SystemSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  }
}
