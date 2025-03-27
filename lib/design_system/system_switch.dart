import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemSwitch extends ConsumerWidget {
  const SystemSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch(
      inactiveThumbColor: Theme.of(context).colorScheme.primary,
      inactiveTrackColor: Theme.of(context).colorScheme.secondary,
      trackOutlineWidth: WidgetStateProperty.all(0.0),
      value: value,
      onChanged: (value) {
        HapticFeedback.selectionClick();
        onChanged(value);
      },
    );
  }
}
