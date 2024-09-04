import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/bottom_nav.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/pages/search_page.dart';
import 'package:practice/pages/settings_page.dart';
import 'package:practice/providers/tab_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _SystemHomeState();
}

class _SystemHomeState extends ConsumerState<HomePage> {
  late final PageController pageController;
  late final ScrollController settingsController;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: ref.read(tabProvider).index);
    settingsController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
            child: PageView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                allowImplicitScrolling: true,
                itemBuilder: (_, i) {
                  switch (i) {
                    case 1:
                      return SearchPage();
                    case 2:
                      return SettingsPage();
                    case 3:
                      return SizedBox.shrink();
                    case 0:
                    default:
                      return ExplorePage();
                  }
                })),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SystemTap(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    ),
                child: SizedBox(
                    height: tapTarget,
                    width: tapTarget,
                    child: Center(
                        child:
                            Icon(PhosphorIcons.magnifying_glass, size: 34)))),
            SystemTap(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPingPage()),
                    ),
                child: Icon(PhosphorIcons.circle_fill, size: 72)),
            SystemTap(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    ),
                child: SizedBox(
                    height: tapTarget,
                    width: tapTarget,
                    child: Center(child: Icon(PhosphorIcons.gear, size: 34)))),
          ],
        )
      ],
    )));
  }
}
