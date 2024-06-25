import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/add_ping_button.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/hide_home_screen_provider.dart';
import 'package:practice/utils/sheets.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!ref.read(hideHomeScreenProviderProvider)) {
        Sheets.showAddPing(context, ref);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!ref.read(hideHomeScreenProviderProvider)) {
          Sheets.showAddPing(context, ref);
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PingList(),
        IgnorePointer(
            ignoring: true,
            child: AnimatedOpacity(
                opacity: ref.watch(hideHomeScreenProviderProvider) ? 1 : 0,
                duration: duration,
                child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor))),
        Padding(
            padding: EdgeInsets.only(
                right: spacingFive,
                bottom: spacingFive + MediaQuery.of(context).padding.bottom),
            child:
                Align(alignment: Alignment.bottomRight, child: AddPingButton()))
      ],
    );
  }
}
