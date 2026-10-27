import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/focus_grid_zoom.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/extensions/browse_enum_extensions.dart';

class Dial extends ConsumerWidget {
  const Dial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(currentBrowseModeProvider);
    // The needle turns along with the zoom (it snaps with Reduce Motion on).
    final needleDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : FocusGridMotion.zoom;

    return IgnorePointer(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
                offset: Offset(0, 0),
                child: Container(
                    height: pingButtonSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -(pingButtonSize / 2 + 20)),
                          child: Column(children: [
                            SystemText(
                              text: mode.title().toLowerCase(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: modeDialHeight,
                              width: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ]),
                        ),
                        TweenAnimationBuilder<double>(
                          // -45° for grid, 45° for focus, in radians.
                          tween: Tween(
                              end: (mode == BrowseEnum.grid ? -45 : 45) *
                                  3.141592653589793 /
                                  180),
                          duration: needleDuration,
                          curve: FocusGridMotion.zoomCurve,
                          builder: (context, angle, child) =>
                              Transform.rotate(angle: angle, child: child),
                          child: Transform.translate(
                            offset: Offset(0, -(pingButtonSize / 2 + 13)),
                            child: Container(
                              height: modeDialHeight / 2,
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    )))));
  }
}
