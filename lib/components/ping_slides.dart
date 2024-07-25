import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/resizing_text.dart';
import 'package:practice/components/resonant_ping.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/pages/details_page.dart';
import 'package:practice/providers/pings_provider.dart';

class PingSlides extends ConsumerWidget {
  const PingSlides({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(pingsProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => CardSwiper(
          cardsCount: pingsValue.length,
          numberOfCardsDisplayed: 4,
          backCardOffset: const Offset(spacingSeven, spacingSix),
          padding: const EdgeInsets.all(spacingFour),
          cardBuilder: (
            context,
            i,
            horizontalThresholdPercentage,
            verticalThresholdPercentage,
          ) {
            final ping = pingsValue[i];

            if (i == pingsValue.length - 1 &&
                pingsValue.length % fetchLimit == 0) {
              ref.read(pingsProvider.notifier).scroll();
            }

            return Center(
                child: SystemTap(
                    child: AspectRatio(
                        aspectRatio: 1.0,
                        child: PingBackground(
                            child: Stack(children: [
                          Padding(
                              padding: EdgeInsets.all(spacingFive),
                              child: ResizingText(
                                text: ping.text,
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: EdgeInsets.all(spacingFour),
                                  child: ResonantPing(ping: ping)))
                        ]))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(ping: ping)),
                      );
                    }));
          },
        ),
      AsyncError() => SystemText(text: "Error"),
      _ => SystemLoader()
    };
  }
}
