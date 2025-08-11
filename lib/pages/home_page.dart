import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/circular_gesture_detector.dart';
import 'package:practice/components/dial.dart';
import 'package:practice/components/fade.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/pages/home_page_explore.dart';
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
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onNavigationReturn() {
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

  Widget _buildBottomNavigation() {
    final bottomNav = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Fade(),
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
                  child: Icon(
                    PhosphorIcons.magnifying_glass,
                    size: 34,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SystemTap(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewPingPage()),
              ),
              child: Icon(
                PhosphorIcons.circle_fill,
                size: pingButtonSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SystemTap(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
                _onNavigationReturn();
              },
              child: SizedBox(
                height: tapTarget,
                width: tapTarget,
                child: Center(
                  child: Icon(
                    PhosphorIcons.gear,
                    size: 34,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return CircularGestureDetector(
      onAngleUpdate: (angleDiff) {
        final browseNotifier = ref.read(browseTempProvider.notifier);
        final currentMode = ref.read(browseTempProvider);

        if (angleDiff > 0 &&
            (currentMode == null || currentMode == BrowseEnum.grid)) {
          HapticFeedback.lightImpact();
          browseNotifier.setMode(BrowseEnum.focus);
        }
        else if (angleDiff < 0 &&
            (currentMode == null || currentMode == BrowseEnum.focus)) {
          HapticFeedback.lightImpact();
          browseNotifier.setMode(BrowseEnum.grid);
        }
      },
      child: bottomNav,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: pingButtonSize),
              child: HomePageExplore(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomNavigation(),
            ),
            Dial()
          ],
        ),
      ),
    );
  }
}
