import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/nav_bar_button.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/enums/sub_pages_enum.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav(
      {super.key,
      required this.pageController,
      required this.browseController,
      required this.settingsController,
      required this.focusNode});

  final PageController pageController;
  final ScrollController browseController;
  final ScrollController settingsController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      const SystemDivider(),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: spacingFour),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            NavBarButton(
                focusNode: focusNode,
                page: SubPagesEnum.browse,
                scrollController: browseController,
                pageController: pageController),
            NavBarButton(
                focusNode: focusNode,
                page: SubPagesEnum.search,
                pageController: pageController),
            NavBarButton(
                focusNode: focusNode,
                page: SubPagesEnum.settings,
                scrollController: settingsController,
                pageController: pageController),
            NavBarButton(
                focusNode: focusNode,
                page: SubPagesEnum.add,
                pageController: pageController),
          ]))
    ]);
  }
}
