import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/resizing_text.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/pages/details_page.dart';
import 'package:practice/providers/pings_provider.dart';

class PingGrid extends ConsumerWidget {
  const PingGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(pingsProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => GridView.builder(
          itemCount: pingsValue.length,
          padding: EdgeInsets.all(spacingFour),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: spacingThree,
            mainAxisSpacing: spacingThree,
          ),
          itemBuilder: (context, i) {
            final ping = pingsValue[i];

            if (i == pingsValue.length - 1 &&
                pingsValue.length % fetchLimit == 0) {
              ref.read(pingsProvider.notifier).scroll();
            }

            return SystemTap(
                child: Stack(children: [
                  Padding(
                      padding: EdgeInsets.all(spacingFive),
                      child: ResizingText(
                        text: ping.text,
                      )),
                ]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(ping: ping)),
                  );
                });
          },
        ),
      AsyncError() => SystemText(text: "Error"),
      _ => SystemLoader()
    };
  }
}
