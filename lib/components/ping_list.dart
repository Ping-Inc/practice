import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/import_pings_button.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/providers/pings_provider.dart';

class PingList extends ConsumerWidget {
  // Widget pingCell(BuildContext context, Ping ping) {
  //   return Padding(
  //       padding: EdgeInsets.only(
  //           left: spacingTwo, bottom: spacingThree, right: spacingTwo),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text(ping.text),
  //         Text(DateFormat('h:mm a - EEEE MMMM d, y').format(ping.time),
  //             style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
  //       ]));
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(pingsProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => pingsValue.isEmpty
          ? Center(
              child:
                  Column(children: [Text("No pings yet"), ImportPingsButton()]))
          : GridView.builder(
              itemCount: pingsValue.length + 1,
              padding: EdgeInsets.only(
                  left: spacingTwo,
                  right: spacingTwo,
                  top: spacingFour + MediaQuery.of(context).padding.top,
                  bottom: spacingFour + MediaQuery.of(context).padding.bottom),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: spacingTwo,
                mainAxisSpacing: spacingTwo,
              ),
              itemBuilder: (context, i) {
                if (i == pingsValue.length) {
                  return ImportPingsButton();
                }

                final ping = pingsValue[i];

                if (i == pingsValue.length - 1 &&
                    pingsValue.length % fetchLimit == 0) {
                  ref.read(pingsProvider.notifier).scroll();
                }

                return ResizingTextCell(text: ping.text);
              },
            ),
      AsyncError() => Text("Error"),
      _ => SystemLoader()
    };
  }
}
