import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/meta_data/active_ping_circle.dart';
import 'package:practice/components/ping_id_text.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';

class PingIdCell extends StatelessWidget {
  const PingIdCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: () {
          context.pop();
        },
        child: Row(children: [
          ActivePingCircle(),
          SizedBox(width: spacingThree),
          PingIdText()
        ]));
  }
}
