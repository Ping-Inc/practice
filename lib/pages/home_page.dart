import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/dial.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/enums/filters_enum.dart';
import 'package:practice/extensions/filters_enum_extensions.dart';
import 'package:practice/pages/explore_page.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/pages/search_page.dart';
import 'package:practice/pages/settings_page.dart';
import 'package:practice/providers/browse_temp_provider.dart';
import 'package:practice/providers/local_backup_on_provider.dart';
import 'package:practice/utils/backup_utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController =
        TabController(length: FiltersEnum.values.length, vsync: this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        if (ref.read(localBackupOnProvider)) BackupUtils.backupPings();
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
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Column(children: [
          Expanded(
            child: DefaultTabController(
              length: FiltersEnum.values.length,
              child: ExplorePage(
                tabController: _tabController,
                tabs: FiltersEnum.values.map((filter) {
                  return filter.title();
                }).toList(),
                children: FiltersEnum.values.map((filter) {
                  return filter.page(DateTime.now());
                }).toList(),
              ),
            ),
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta != null &&
                    details.primaryDelta!.abs() > 8) {
                  final browseNotifier = ref.read(browseTempProvider.notifier);
                  final currentMode = ref.read(browseTempProvider);

                  if (details.primaryDelta! > 0 &&
                      (currentMode == null ||
                          currentMode == BrowseEnum.focus)) {
                    HapticFeedback.lightImpact();
                    browseNotifier.setMode(BrowseEnum.grid);
                  } else if (details.primaryDelta! < 0 &&
                      (currentMode == null || currentMode == BrowseEnum.grid)) {
                    HapticFeedback.lightImpact();
                    browseNotifier.setMode(BrowseEnum.focus);
                  }
                }
              },
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SystemTap(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()),
                            ),
                        child: SizedBox(
                            height: tapTarget,
                            width: tapTarget,
                            child: Center(
                                child: Icon(PhosphorIcons.magnifying_glass,
                                    size: 34)))),
                    SystemTap(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPingPage()),
                            ),
                        child: Icon(PhosphorIcons.circle_fill,
                            size: pingButtonSize)),
                    SystemTap(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()),
                            ),
                        child: SizedBox(
                            height: tapTarget,
                            width: tapTarget,
                            child: Center(
                                child: Icon(PhosphorIcons.gear, size: 34)))),
                  ],
                )
              ]))
        ]),
        Dial()
      ]),
    ));
  }
}
