import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/resizing_text.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_loader.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/pages/details_page.dart';

class PingSlides extends StatefulWidget {
  const PingSlides(
      {super.key,
      required this.swipeController,
      required this.scroll,
      required this.asyncPings,
      required this.count});

  final CardSwiperController swipeController;
  final VoidCallback scroll;
  final AsyncValue<List<Ping>> asyncPings;
  final int count;

  @override
  State<PingSlides> createState() => _PingSlidesState();
}

class _PingSlidesState extends State<PingSlides> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return switch (widget.asyncPings) {
      AsyncData(value: final pingsValue) => SafeArea(
            child: Column(children: [
          if (widget.count != 0)
            Padding(
              padding: EdgeInsets.all(spacingFour),
              child: SystemText(text: "$index/${widget.count}"),
            ),
          Expanded(
              child: pingsValue.isEmpty
                  ? Center(child: SystemText(text: 'No pings for this time'))
                  : CardSwiper(
                      controller: widget.swipeController,
                      cardsCount: pingsValue.length,
                      numberOfCardsDisplayed: pingsValue.length == 1 ? 1 : 2,
                      backCardOffset: const Offset(0, 0),
                      onSwipe: (pi, ni, direction) {
                        if (ni != null) {
                          setState(() {
                            index = ni + 1;
                          });
                        }

                        return true;
                      },
                      padding: EdgeInsets.only(
                          top: spacingFour,
                          left: spacingFour,
                          right: spacingFour,
                          bottom: spacingNine),
                      cardBuilder: (
                        context,
                        i,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) {
                        final ping = pingsValue[i];

                        if (i == pingsValue.length - 1 &&
                            pingsValue.length % fetchLimit == 0) {
                          widget.scroll();
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
                                    ]))),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                            ping: ping, title: "Slides")),
                                  );
                                }));
                      },
                    ))
        ])),
      AsyncError() => SystemText(text: "Error"),
      _ => SystemLoader()
    };
  }
}
