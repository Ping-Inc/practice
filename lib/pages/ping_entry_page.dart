import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/current_ping_resizing_text_cell.dart';
import 'package:practice/components/new_ping_button.dart';
import 'package:practice/components/system_back_button.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class PingEntryPage extends ConsumerStatefulWidget {
  const PingEntryPage({super.key});

  @override
  ConsumerState<PingEntryPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<PingEntryPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  Widget build(BuildContext context) {
    ref.listen(pingsProvider, (previous, next) {
      controller.clear();
    });

    return Scaffold(
        body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          TopNav(child: SystemBackButton()),
          Expanded(
              child: Center(
            child: CurrentPingResizingTextCell(),
          )),
          SizedBox(
            height: spacingFive,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NewPingButton(textEditingController: controller),
            ],
          ),
          SizedBox(
            height: 0,
            width: 0,
            child: TextField(
              focusNode: focusNode,
              autofocus: true,
              controller: controller,
              onChanged: (value) =>
                  {ref.read(currentPingProvider.notifier).set(value)},
              onSubmitted: (value) {
                HapticFeedback.selectionClick();
                ref.read(pingsProvider.notifier).addPing(controller.text);
                ref.read(currentPingProvider.notifier).reset();
                FocusScope.of(context).requestFocus(focusNode);
              },
            ),
          ),
          SizedBox(
            height: spacingFive,
          )
        ]));
  }
}
