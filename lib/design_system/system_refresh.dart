// ignore_for_file: deprecated_member_use

library;

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/design_system/system_text.dart';

// The over-scroll distance that moves the indicator to its maximum
// displacement, as a percentage of the scrollable's container extent.
const double _kDragContainerExtentPercentage = 0.25;

// How much the scroll's drag gesture can overshoot the SystemRefresh's
// displacement; max displacement = _kDragSizeFactorLimit * displacement.
const double _kDragSizeFactorLimit = 1.5;

// When the scroll ends, the duration of the refresh indicator's animation
// to the SystemRefresh's displacement.
const Duration _kIndicatorSnapDuration = Duration(milliseconds: 150);

// The duration of the ScaleTransition that starts when the refresh action
// has completed.
const Duration _kIndicatorScaleDuration = Duration(milliseconds: 200);

/// The signature for a function that's called when the user has dragged a
/// [SystemRefresh] far enough to demonstrate that they want the app to
/// refresh. The returned [Future] must complete when the refresh operation is
/// finished.
///
/// Used by [SystemRefresh.onRefresh].
typedef RefreshCallback = Future<void> Function();

/// Indicates current status of Material `SystemRefresh`.
enum SystemRefreshStatus {
  /// Pointer is down.
  drag,

  /// Dragged far enough that an up event will run the onRefresh callback.
  armed,

  /// Animating to the indicator's final "displacement".
  snap,

  /// Running the refresh callback.
  refresh,

  /// Animating the indicator's fade-out after refreshing.
  done,

  /// Animating the indicator's fade-out after not arming.
  canceled,
}

/// Used to configure how [SystemRefresh] can be triggered.
enum SystemRefreshTriggerMode {
  /// The indicator can be triggered regardless of the scroll position
  /// of the [Scrollable] when the drag starts.
  anywhere,

  /// The indicator can only be triggered if the [Scrollable] is at the edge
  /// when the drag starts.
  onEdge,
}

/// A widget that supports the Material "swipe to refresh" idiom.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=ORApMlzwMdM}
///
/// When the child's [Scrollable] descendant overscrolls, an animated circular
/// progress indicator is faded into view. When the scroll ends, if the
/// indicator has been dragged far enough for it to become completely opaque,
/// the [onRefresh] callback is called. The callback is expected to update the
/// scrollable's contents and then complete the [Future] it returns. The refresh
/// indicator disappears after the callback's [Future] has completed.
///
/// The trigger mode is configured by [SystemRefresh.triggerMode].
///
/// {@tool dartpad}
/// This example shows how [SystemRefresh] can be triggered in different ways.
///
/// ** See code in examples/api/lib/material/refresh_indicator/refresh_indicator.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to trigger [SystemRefresh] in a nested scroll view using
/// the [notificationPredicate] property.
///
/// ** See code in examples/api/lib/material/refresh_indicator/refresh_indicator.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to use [SystemRefresh] without the spinner.
///
/// ** See code in examples/api/lib/material/refresh_indicator/refresh_indicator.2.dart **
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Refresh indicator does not show up
///
/// The [SystemRefresh] will appear if its scrollable descendant can be
/// overscrolled, i.e. if the scrollable's content is bigger than its viewport.
/// To ensure that the [SystemRefresh] will always appear, even if the
/// scrollable's content fits within its viewport, set the scrollable's
/// [Scrollable.physics] property to [AlwaysScrollableScrollPhysics]:
///
/// ```dart
/// ListView(
///   physics: const AlwaysScrollableScrollPhysics(),
///   // ...
/// )
/// ```
///
/// A [SystemRefresh] can only be used with a vertical scroll view.
///
/// See also:
///
///  * <https://material.io/design/platform-guidance/android-swipe-to-refresh.html>
///  * [SystemRefreshState], can be used to programmatically show the refresh indicator.
///  * [RefreshProgressIndicator], widget used by [SystemRefresh] to show
///    the inner circular progress spinner during refreshes.
///  * [CupertinoSliverRefreshControl], an iOS equivalent of the pull-to-refresh pattern.
///    Must be used as a sliver inside a [CustomScrollView] instead of wrapping
///    around a [ScrollView] because it's a part of the scrollable instead of
///    being overlaid on top of it.
class SystemRefresh extends StatefulWidget {
  /// Creates a refresh indicator.
  ///
  /// The [onRefresh], [child], and [notificationPredicate] arguments must be
  /// non-null. The default
  /// [displacement] is 40.0 logical pixels.
  ///
  /// The [semanticsLabel] is used to specify an accessibility label for this widget.
  /// If it is null, it will be defaulted to [MaterialLocalizations.SystemRefreshSemanticLabel].
  /// An empty string may be passed to avoid having anything read by screen reading software.
  /// The [semanticsValue] may be used to specify progress on the widget.
  const SystemRefresh({
    super.key,
    required this.child,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = 2,
    this.triggerMode = SystemRefreshTriggerMode.onEdge,
    this.elevation = 2.0,
  })  : onStatusChange = null,
        assert(elevation >= 0.0);

  /// Creates an adaptive [SystemRefresh] based on whether the target
  /// platform is iOS or macOS, following Material design's
  /// [Cross-platform guidelines](https://material.io/design/platform-guidance/cross-platform-adaptation.html).
  ///
  /// When the descendant overscrolls, a different spinning progress indicator
  /// is shown depending on platform. On iOS and macOS,
  /// [CupertinoActivityIndicator] is shown, but on all other platforms,
  /// [CircularProgressIndicator] appears.
  ///
  /// If a [CupertinoActivityIndicator] is shown, the following parameters are ignored:
  /// [backgroundColor], [semanticsLabel], [semanticsValue], [strokeWidth].
  ///
  /// The target platform is based on the current [Theme]: [ThemeData.platform].
  ///
  /// Notably the scrollable widget itself will have slightly different behavior
  /// from [CupertinoSliverRefreshControl], due to a difference in structure.
  const SystemRefresh.adaptive({
    super.key,
    required this.child,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = 2,
    this.triggerMode = SystemRefreshTriggerMode.onEdge,
    this.elevation = 2.0,
  })  : onStatusChange = null,
        assert(elevation >= 0.0);

  /// Creates a [SystemRefresh] with no spinner and calls `onRefresh` when
  /// successfully armed by a drag event.
  ///
  /// Events can be optionally listened by using the `onStatusChange` callback.
  const SystemRefresh.noSpinner({
    super.key,
    required this.child,
    required this.onRefresh,
    this.onStatusChange,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.triggerMode = SystemRefreshTriggerMode.onEdge,
    this.elevation = 2.0,
  })  : displacement = 0.0,
        edgeOffset = 0.0,
        color = null,
        backgroundColor = null,
        strokeWidth = 0.0,
        assert(elevation >= 0.0);

  /// The widget below this widget in the tree.
  ///
  /// The refresh indicator will be stacked on top of this child. The indicator
  /// will appear when child's Scrollable descendant is over-scrolled.
  ///
  /// Typically a [ListView] or [CustomScrollView].
  final Widget child;

  /// The distance from the child's top or bottom [edgeOffset] where
  /// the refresh indicator will settle. During the drag that exposes the refresh
  /// indicator, its actual displacement may significantly exceed this value.
  ///
  /// In most cases, [displacement] distance starts counting from the parent's
  /// edges. However, if [edgeOffset] is larger than zero then the [displacement]
  /// value is calculated from that offset instead of the parent's edge.
  final double displacement;

  /// The offset where [RefreshProgressIndicator] starts to appear on drag start.
  ///
  /// Depending whether the indicator is showing on the top or bottom, the value
  /// of this variable controls how far from the parent's edge the progress
  /// indicator starts to appear. This may come in handy when, for example, the
  /// UI contains a top [Widget] which covers the parent's edge where the progress
  /// indicator would otherwise appear.
  ///
  /// By default, the edge offset is set to 0.
  ///
  /// See also:
  ///
  ///  * [displacement], can be used to change the distance from the edge that
  ///    the indicator settles.
  final double edgeOffset;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// Called to get the current status of the [SystemRefresh] to update the UI as needed.
  /// This is an optional parameter, used to fine tune app cases.
  final ValueChanged<SystemRefreshStatus?>? onStatusChange;

  /// The progress indicator's foreground color. The current theme's
  /// [ColorScheme.primary] by default.
  final Color? color;

  /// The progress indicator's background color. The current theme's
  /// [ThemeData.canvasColor] by default.
  final Color? backgroundColor;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsLabel}
  ///
  /// This will be defaulted to [MaterialLocalizations.SystemRefreshSemanticLabel]
  /// if it is null.
  final String? semanticsLabel;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsValue}
  final String? semanticsValue;

  /// Defines [strokeWidth] for `SystemRefresh`.
  ///
  /// By default, the value of [strokeWidth] is 2.0 pixels.
  final double strokeWidth;

  /// Defines how this [SystemRefresh] can be triggered when users overscroll.
  ///
  /// The [SystemRefresh] can be pulled out in two cases,
  /// 1, Keep dragging if the scrollable widget at the edge with zero scroll position
  ///    when the drag starts.
  /// 2, Keep dragging after overscroll occurs if the scrollable widget has
  ///    a non-zero scroll position when the drag starts.
  ///
  /// If this is [SystemRefreshTriggerMode.anywhere], both of the cases above can be triggered.
  ///
  /// If this is [SystemRefreshTriggerMode.onEdge], only case 1 can be triggered.
  ///
  /// Defaults to [SystemRefreshTriggerMode.onEdge].
  final SystemRefreshTriggerMode triggerMode;

  /// Defines the elevation of the underlying [SystemRefresh].
  ///
  /// Defaults to 2.0.
  final double elevation;

  @override
  SystemRefreshState createState() => SystemRefreshState();
}

/// Contains the state for a [SystemRefresh]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class SystemRefreshState extends State<SystemRefresh>
    with TickerProviderStateMixin<SystemRefresh> {
  late AnimationController _positionController;
  late AnimationController _scaleController;
  late Animation<double> _positionFactor;
  late Animation<double> _scaleFactor;
  late Animation<Color?> _valueColor;

  SystemRefreshStatus? _status;
  late Future<void> _pendingRefreshFuture;
  bool? _isIndicatorAtTop;
  double? _dragOffset;
  late Color _effectiveValueColor = widget.color ?? Colors.white;

  static final Animatable<double> _kDragSizeFactorLimitTween = Tween<double>(
    begin: 0.0,
    end: _kDragSizeFactorLimit,
  );

  static final Animatable<double> _oneToZeroTween =
      Tween<double>(begin: 1.0, end: 0.0);

  @protected
  @override
  void initState() {
    super.initState();
    _positionController = AnimationController(vsync: this);
    _positionFactor = _positionController.drive(_kDragSizeFactorLimitTween);

    // The "value" of the circular progress indicator during a drag.

    _scaleController = AnimationController(vsync: this);
    _scaleFactor = _scaleController.drive(_oneToZeroTween);
  }

  @protected
  @override
  void didChangeDependencies() {
    _setupColorTween();
    super.didChangeDependencies();
  }

  @protected
  @override
  void didUpdateWidget(covariant SystemRefresh oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _setupColorTween();
    }
  }

  @protected
  @override
  void dispose() {
    _positionController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _setupColorTween() {
    // Reset the current value color.
    _effectiveValueColor =
        widget.color ?? Theme.of(context).colorScheme.primary;
    final Color color = _effectiveValueColor;
    if (color.alpha == 0x00) {
      // Set an always stopped animation instead of a driven tween.
      _valueColor = AlwaysStoppedAnimation<Color>(color);
    } else {
      // Respect the alpha of the given color.
      _valueColor = _positionController.drive(
        ColorTween(
          begin: color.withAlpha(0),
          end: color.withAlpha(color.alpha),
        ).chain(CurveTween(
            curve: const Interval(0.0, 1.0 / _kDragSizeFactorLimit))),
      );
    }
  }

  bool _shouldStart(ScrollNotification notification) {
    // If the notification.dragDetails is null, this scroll is not triggered by
    // user dragging. It may be a result of ScrollController.jumpTo or ballistic scroll.
    // In this case, we don't want to trigger the refresh indicator.
    return ((notification is ScrollStartNotification &&
                notification.dragDetails != null) ||
            (notification is ScrollUpdateNotification &&
                notification.dragDetails != null &&
                widget.triggerMode == SystemRefreshTriggerMode.anywhere)) &&
        ((notification.metrics.axisDirection == AxisDirection.up &&
                notification.metrics.extentAfter == 0.0) ||
            (notification.metrics.axisDirection == AxisDirection.down &&
                notification.metrics.extentBefore == 0.0)) &&
        _status == null &&
        _start(notification.metrics.axisDirection);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }
    if (_shouldStart(notification)) {
      setState(() {
        _status = SystemRefreshStatus.drag;
        widget.onStatusChange?.call(_status);
      });
      return false;
    }
    final bool? indicatorAtTopNow =
        switch (notification.metrics.axisDirection) {
      AxisDirection.down || AxisDirection.up => true,
      AxisDirection.left || AxisDirection.right => null,
    };
    if (indicatorAtTopNow != _isIndicatorAtTop) {
      if (_status == SystemRefreshStatus.drag ||
          _status == SystemRefreshStatus.armed) {
        _dismiss(SystemRefreshStatus.canceled);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_status == SystemRefreshStatus.drag ||
          _status == SystemRefreshStatus.armed) {
        if (notification.metrics.axisDirection == AxisDirection.down) {
          _dragOffset = _dragOffset! - notification.scrollDelta!;
        } else if (notification.metrics.axisDirection == AxisDirection.up) {
          _dragOffset = _dragOffset! + notification.scrollDelta!;
        }
        _checkDragOffset(notification.metrics.viewportDimension);
      }
      if (_status == SystemRefreshStatus.armed &&
          notification.dragDetails == null) {
        // On iOS start the refresh when the Scrollable bounces back from the
        // overscroll (ScrollNotification indicating this don't have dragDetails
        // because the scroll activity is not directly triggered by a drag).
        _show();
      }
    } else if (notification is OverscrollNotification) {
      if (_status == SystemRefreshStatus.drag ||
          _status == SystemRefreshStatus.armed) {
        if (notification.metrics.axisDirection == AxisDirection.down) {
          _dragOffset = _dragOffset! - notification.overscroll;
        } else if (notification.metrics.axisDirection == AxisDirection.up) {
          _dragOffset = _dragOffset! + notification.overscroll;
        }
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_status) {
        case SystemRefreshStatus.armed:
          if (_positionController.value < 1.0) {
            _dismiss(SystemRefreshStatus.canceled);
          } else {
            _show();
          }
        case SystemRefreshStatus.drag:
          _dismiss(SystemRefreshStatus.canceled);
        case SystemRefreshStatus.canceled:
        case SystemRefreshStatus.done:
        case SystemRefreshStatus.refresh:
        case SystemRefreshStatus.snap:
        case null:
          // do nothing
          break;
      }
    }
    return false;
  }

  bool _handleIndicatorNotification(
      OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) {
      return false;
    }
    if (_status == SystemRefreshStatus.drag) {
      notification.disallowIndicator();
      return true;
    }
    return false;
  }

  bool _start(AxisDirection direction) {
    assert(_status == null);
    assert(_isIndicatorAtTop == null);
    assert(_dragOffset == null);
    switch (direction) {
      case AxisDirection.down:
      case AxisDirection.up:
        _isIndicatorAtTop = true;
      case AxisDirection.left:
      case AxisDirection.right:
        _isIndicatorAtTop = null;
        // we do not support horizontal scroll views.
        return false;
    }
    _dragOffset = 0.0;
    _scaleController.value = 0.0;
    _positionController.value = 0.0;
    return true;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_status == SystemRefreshStatus.drag ||
        _status == SystemRefreshStatus.armed);
    double newValue =
        _dragOffset! / (containerExtent * _kDragContainerExtentPercentage);
    if (_status == SystemRefreshStatus.armed) {
      newValue = math.max(newValue, 1.0 / _kDragSizeFactorLimit);
    }
    _positionController.value =
        clampDouble(newValue, 0.0, 1.0); // This triggers various rebuilds.
    if (_status == SystemRefreshStatus.drag &&
        _valueColor.value!.alpha == _effectiveValueColor.alpha) {
      _status = SystemRefreshStatus.armed;
      widget.onStatusChange?.call(_status);
    }
  }

  // Stop showing the refresh indicator.
  Future<void> _dismiss(SystemRefreshStatus newMode) async {
    await Future<void>.value();
    // This can only be called from _show() when refreshing and
    // _handleScrollNotification in response to a ScrollEndNotification or
    // direction change.
    assert(newMode == SystemRefreshStatus.canceled ||
        newMode == SystemRefreshStatus.done);
    setState(() {
      _status = newMode;
      widget.onStatusChange?.call(_status);
    });
    switch (_status!) {
      case SystemRefreshStatus.done:
        await _scaleController.animateTo(1.0,
            duration: _kIndicatorScaleDuration);
      case SystemRefreshStatus.canceled:
        await _positionController.animateTo(0.0,
            duration: _kIndicatorScaleDuration);
      case SystemRefreshStatus.armed:
      case SystemRefreshStatus.drag:
      case SystemRefreshStatus.refresh:
      case SystemRefreshStatus.snap:
        assert(false);
    }
    if (mounted && _status == newMode) {
      _dragOffset = null;
      _isIndicatorAtTop = null;
      setState(() {
        _status = null;
      });
    }
  }

  void _show() {
    assert(_status != SystemRefreshStatus.refresh);
    assert(_status != SystemRefreshStatus.snap);
    final Completer<void> completer = Completer<void>();
    _pendingRefreshFuture = completer.future;
    _status = SystemRefreshStatus.snap;
    widget.onStatusChange?.call(_status);
    _positionController
        .animateTo(1.0 / _kDragSizeFactorLimit,
            duration: _kIndicatorSnapDuration)
        .then<void>((void value) {
      if (mounted && _status == SystemRefreshStatus.snap) {
        setState(() {
          // Show the indeterminate progress indicator.
          _status = SystemRefreshStatus.refresh;
        });

        final Future<void> refreshResult = widget.onRefresh();
        refreshResult.whenComplete(() {
          if (mounted && _status == SystemRefreshStatus.refresh) {
            completer.complete();
            _dismiss(SystemRefreshStatus.done);
          }
        });
      }
    });
  }

  /// Show the refresh indicator and run the refresh callback as if it had
  /// been started interactively. If this method is called while the refresh
  /// callback is running, it quietly does nothing.
  ///
  /// Creating the [SystemRefresh] with a [GlobalKey<SystemRefreshState>]
  /// makes it possible to refer to the [SystemRefreshState].
  ///
  /// The future returned from this method completes when the
  /// [SystemRefresh.onRefresh] callback's future completes.
  ///
  /// If you await the future returned by this function from a [State], you
  /// should check that the state is still [mounted] before calling [setState].
  ///
  /// When initiated in this manner, the refresh indicator is independent of any
  /// actual scroll view. It defaults to showing the indicator at the top. To
  /// show it at the bottom, set `atTop` to false.
  Future<void> show({bool atTop = true}) {
    if (_status != SystemRefreshStatus.refresh &&
        _status != SystemRefreshStatus.snap) {
      if (_status == null) {
        _start(atTop ? AxisDirection.down : AxisDirection.up);
      }
      _show();
    }
    return _pendingRefreshFuture;
  }

  @protected
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final Widget child = NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleIndicatorNotification,
        child: widget.child,
      ),
    );
    assert(() {
      if (_status == null) {
        assert(_dragOffset == null);
        assert(_isIndicatorAtTop == null);
      } else {
        assert(_dragOffset != null);
        assert(_isIndicatorAtTop != null);
      }
      return true;
    }());

    return Stack(
      children: <Widget>[
        child,
        if (_status != null)
          Positioned(
            top: _isIndicatorAtTop! ? widget.edgeOffset : null,
            bottom: !_isIndicatorAtTop! ? widget.edgeOffset : null,
            left: 0.0,
            right: 0.0,
            child: SizeTransition(
              axisAlignment: _isIndicatorAtTop! ? 1.0 : -1.0,
              sizeFactor: _positionFactor, // This is what brings it down.
              child: Padding(
                padding: _isIndicatorAtTop!
                    ? EdgeInsets.only(top: widget.displacement)
                    : EdgeInsets.only(bottom: widget.displacement),
                child: Align(
                  alignment: _isIndicatorAtTop!
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  child: ScaleTransition(
                    scale: _scaleFactor,
                    child: AnimatedBuilder(
                      animation: _positionController,
                      builder: (BuildContext context, Widget? child) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.dice_four,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 4),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: SystemText(
                                    text: "random",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                            ]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
