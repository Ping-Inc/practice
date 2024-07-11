import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/design_system/system_text.dart';

class ICloudSyncOnText extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SystemText(
          text: "iCloud",
        ),
        SystemSwitch(
          value: true,
          onChanged: (p0) {},
        )
      ],
    );
  }
}
