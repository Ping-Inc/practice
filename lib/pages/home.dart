import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/hide_home_screen_provider.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SafeArea(bottom: false, child: PingList()),
        IgnorePointer(
            ignoring: true,
            child: AnimatedOpacity(
                opacity: ref.watch(hideHomeScreenProviderProvider) ? 1 : 0,
                duration: duration,
                child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor))),
      ],
    );
  }
}
