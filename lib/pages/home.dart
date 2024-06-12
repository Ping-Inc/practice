import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/add_ping_button.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(child: PingList()),
        SystemDivider(),
        Padding(
            padding: EdgeInsets.all(spacingFour),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(PhosphorIcons.magnifying_glass)),
                AddPingButton(),
              ],
            ))
      ],
    );
  }
}
