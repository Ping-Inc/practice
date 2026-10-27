import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/providers/browse_provider.dart';
import 'package:practice/providers/browse_temp_provider.dart';

/// The view the dial is set to right now (a temporary turn of the dial wins
/// over the default from Settings › Layout).
final currentBrowseModeProvider = Provider<BrowseEnum>((ref) {
  return ref.watch(browseTempProvider) ?? ref.watch(browseProvider);
});

/// Timing shared by the zoom and the dial's needle, from the prototype.
class FocusGridMotion {
  FocusGridMotion._();

  static const Duration zoom = Duration(milliseconds: 480);
  static const Duration fade = Duration(milliseconds: 360);
  static const Curve zoomCurve = Cubic(0.2, 0.7, 0.2, 1);
  static const Curve fadeCurve = Curves.ease;

  /// With iOS's Reduce Motion on: a short fade, no change in size.
  static const Duration reducedFade = Duration(milliseconds: 200);
}

/// Switches between focus and grid with a zoom: going to grid, focus shrinks
/// away while the grid comes in from larger; going to focus, the reverse.
/// Both views are only drawn while the zoom plays.
class FocusGridZoom extends ConsumerStatefulWidget {
  const FocusGridZoom({super.key, required this.focus, required this.grid});

  final WidgetBuilder focus;
  final WidgetBuilder grid;

  @override
  ConsumerState<FocusGridZoom> createState() => _FocusGridZoomState();
}

class _FocusGridZoomState extends ConsumerState<FocusGridZoom>
    with TickerProviderStateMixin {
  // 0 = focus, 1 = grid. Size and fade run separately, like CSS transitions,
  // so turning back mid-zoom continues smoothly from where it is.
  late final AnimationController _zoom;
  late final AnimationController _fade;

  // How far focus shrinks, and how large the grid starts.
  static const double _focusAway = 0.72;
  static const double _gridAway = 1.35;
  // Zoom around the point where the focus card sits (38% down).
  static const Alignment _origin = Alignment(0, -0.24);

  @override
  void initState() {
    super.initState();
    final start = ref.read(currentBrowseModeProvider) == BrowseEnum.grid ? 1.0 : 0.0;
    _zoom = AnimationController(vsync: this, value: start);
    _fade = AnimationController(vsync: this, value: start);
  }

  @override
  void dispose() {
    _zoom.dispose();
    _fade.dispose();
    super.dispose();
  }

  void _goTo(BrowseEnum mode) {
    final target = mode == BrowseEnum.grid ? 1.0 : 0.0;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    if (reduceMotion) {
      _zoom.value = target;
      _fade.animateTo(target,
          duration: FocusGridMotion.reducedFade, curve: Curves.easeInOut);
      return;
    }
    _zoom.animateTo(target,
        duration: FocusGridMotion.zoom, curve: FocusGridMotion.zoomCurve);
    _fade.animateTo(target,
        duration: FocusGridMotion.fade, curve: FocusGridMotion.fadeCurve);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(currentBrowseModeProvider, (_, mode) => _goTo(mode));
    final toGrid = ref.watch(currentBrowseModeProvider) == BrowseEnum.grid;

    return AnimatedBuilder(
      animation: Listenable.merge([_zoom, _fade]),
      builder: (context, _) {
        final z = _zoom.value;
        final f = _fade.value;
        final showFocus = f < 1 || z < 1;
        final showGrid = f > 0 || z > 0;

        // Each view keeps its identity (a key), so when the other one is
        // removed at the end of the zoom it isn't rebuilt from scratch.
        Widget layer(String key, Widget child, double scale, double opacity,
            bool active) {
          return IgnorePointer(
            key: ValueKey(key),
            // Only the view being switched to takes touches mid-zoom.
            ignoring: !active,
            child: Opacity(
              opacity: opacity.clamp(0.0, 1.0),
              child: Transform.scale(
                  scale: scale, alignment: _origin, child: child),
            ),
          );
        }

        // Clipped, so the enlarged view never spills over the lens tabs.
        return ClipRect(
            child: Stack(
          fit: StackFit.expand,
          children: [
            if (showFocus)
              layer('focus', widget.focus(context), 1 + (_focusAway - 1) * z,
                  1 - f, !toGrid),
            if (showGrid)
              layer('grid', widget.grid(context),
                  _gridAway + (1 - _gridAway) * z, f, toGrid),
          ],
        ));
      },
    );
  }
}
