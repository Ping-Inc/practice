import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';

class SystemSwitch extends ConsumerWidget {
  const SystemSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseColor = ref.watch(baseColorProvider);

    return Switch(
      inactiveThumbColor: baseColor.background,
      inactiveTrackColor: baseColor.secondary,
      trackOutlineWidth: WidgetStateProperty.all(0.0),
      value: value,
      onChanged: onChanged,
    );
  }
}
