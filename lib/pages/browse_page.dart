import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/browse_mode_selector.dart';
import 'package:practice/components/filter_incrementer.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/components/ping_slides.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowsePage extends ConsumerStatefulWidget {
  const BrowsePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<BrowsePage> createState() => _BrowserPageState();
}

class _BrowserPageState extends ConsumerState<BrowsePage> {
  late final PageController browseController;
  late final ScrollController listController;

  @override
  void initState() {
    super.initState();

    browseController =
        PageController(initialPage: ref.read(browseProvider).index);
    listController = ScrollController();
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              TopNav(
                  child: SystemButton(
                onTap: () => context.pop(),
                text: widget.title,
                icon: PhosphorIcons.caret_left,
              )),
              SystemDivider(),
              FilterIncrementer(),
              SystemDivider(),
              Expanded(
                  child: Stack(
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
                            return PingList(controller: listController);
                          case 0:
                          default:
                            return PingSlides();
                        }
                      }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: spacingFive +
                                  MediaQuery.of(context).padding.bottom),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BrowseModeSelector(
                                    controller: listController,
                                    browseController: browseController)
                              ]))
                    ],
                  ),
                ],
              ))
            ])));
  }
}
