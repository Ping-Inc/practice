import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/browse_mode_selector.dart';
import 'package:practice/components/ping_grid.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/components/ping_slides.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowsePage extends ConsumerStatefulWidget {
  const BrowsePage({super.key, required this.controller});

  final ScrollController controller;

  @override
  ConsumerState<BrowsePage> createState() => _BrowserPageState();
}

class _BrowserPageState extends ConsumerState<BrowsePage> {
  late final PageController browseController;

  @override
  void initState() {
    super.initState();

    browseController =
        PageController(initialPage: ref.read(browseProvider).index);
  }

  @override
  Widget build(BuildContext contex) {
    return Stack(
      children: [
        PageView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            controller: browseController,
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            itemBuilder: (_, i) {
              switch (i) {
                case 1:
                  return PingList(controller: widget.controller);
                case 2:
                  return PingGrid(controller: widget.controller);
                case 0:
                default:
                  return PingSlides();
              }
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: spacingFive),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  BrowseModeSelector(
                      controller: widget.controller,
                      browseController: browseController)
                ]))
          ],
        ),
      ],
    );
  }
}
