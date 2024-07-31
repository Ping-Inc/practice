import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/browse_mode_button.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/browse_enum.dart';

class BrowseModeSelector extends ConsumerWidget {
  const BrowseModeSelector(
      {super.key,
      required this.scrollController,
      required this.browseController,
      required this.swipeController});

  final ScrollController scrollController;
  final PageController browseController;
  final CardSwiperController swipeController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.all(spacingTwo),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 1.5,
            ),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(999)),
        child: Row(
          children: [
            BrowseModeButton(
                browseMode: BrowseEnum.slides,
                scrollController: scrollController,
                browseController: browseController,
                swipeController: swipeController),
            BrowseModeButton(
                browseMode: BrowseEnum.list,
                scrollController: scrollController,
                browseController: browseController,
                swipeController: swipeController),
          ],
        ));
  }
}
