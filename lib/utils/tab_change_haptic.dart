import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A light tick each time the selected tab changes: straight away when a tab
/// is tapped, and as a swipe passes halfway to the next tab. A swipe that's
/// let go before halfway (and springs back) doesn't tick.
class TabChangeHaptic {
  TabChangeHaptic(this.controller) : _tab = controller.index {
    // Taps change the controller; swipes only move its animation.
    controller.addListener(_onMove);
    controller.animation!.addListener(_onMove);
  }

  final TabController controller;
  int _tab;

  void _onMove() {
    // While a tapped tab animates in, its index is already the new one;
    // while swiping, the nearest tab is the one the swipe would land on.
    final tab = controller.indexIsChanging
        ? controller.index
        : controller.animation!.value.round();
    if (tab == _tab) return;
    _tab = tab;
    HapticFeedback.selectionClick();
  }

  void dispose() {
    controller.removeListener(_onMove);
    controller.animation?.removeListener(_onMove);
  }
}
