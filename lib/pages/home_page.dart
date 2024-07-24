import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/bottom_nav.dart';
import 'package:practice/pages/browse_page.dart';
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
  late final ScrollController browseController;
  late final ScrollController settingsController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: ref.read(tabProvider).index);
    browseController = ScrollController();
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
                      return SettingsPage(
                        controller: settingsController,
                      );
                    case 3:
                      return SizedBox.shrink();
                    case 0:
                    default:
                      return BrowsePage(controller: browseController);
                  }
                })),
        BottomNav(
          pageController: pageController,
          browseController: browseController,
          settingsController: settingsController,
        )
      ],
    )));
  }
}
