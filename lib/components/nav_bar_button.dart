import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/sub_pages_enum.dart';
import 'package:practice/extensions/sub_pages_enum_extensions.dart';
import 'package:practice/pages/ping_entry_page.dart';
import 'package:practice/providers/tab_provider.dart';

class NavBarButton extends ConsumerWidget {
  const NavBarButton(
      {super.key,
      required this.page,
      this.scrollController,
      required this.pageController});

  final SubPagesEnum page;
  final ScrollController? scrollController;
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool focused = ref.watch(tabProvider) == page;

    return SystemTap(
      onTap: () => {
        if (page == SubPagesEnum.add)
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PingEntryPage()),
            )
          }
        else if (focused &&
            scrollController != null &&
            scrollController!.hasClients)
          {scrollController!.animateTo(0, duration: duration, curve: curve)}
        else
          {
            ref.read(tabProvider.notifier).setTab(page),
            pageController.jumpToPage(page.index),
            FocusScope.of(context).unfocus()
          }
      },
      child: SizedBox(
          height: tapTarget,
          width: tapTarget,
          child: Center(
              child:
                  Icon(focused ? page.iconFilled() : page.icon(), size: 34))),
    );
  }
}
