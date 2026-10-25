import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_action_row.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_refresh.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/feature_flags_provider.dart';
import 'package:practice/providers/pings_focus_provider.dart';
import 'package:practice/utils/ping_date_utils.dart';

class PingFocusList extends ConsumerStatefulWidget {
  const PingFocusList({
    super.key,
    required this.pings,
    this.sortByResonance = false,
    this.sortByPlaced = false,
  });

  final List<PingData> pings;
  final bool sortByResonance;
  final bool sortByPlaced;

  @override
  ConsumerState<PingFocusList> createState() => _PingFocusListState();
}

class _PingFocusListState extends ConsumerState<PingFocusList> {
  late PageController _pageController;
  int i = 0;

  @override
  void initState() {
    super.initState();
    // Initialize controller and index based on the preserved focusedPingId
    final focusedId = ref.read(focusedPingIdProvider);
    final initialIndex = widget.pings.indexWhere((p) => p.id == focusedId);
    i = initialIndex != -1 ? initialIndex : 0;
    
    _pageController = PageController(
      viewportFraction: 0.9,
      initialPage: i,
    );

    // Update the provider whenever the page changes
    _pageController.addListener(() {
      int newI = _pageController.page!.round();

      if (i != newI) {
        setState(() {
          i = newI;
        });
        // Update the provider with the new focused ping ID
        if (i >= 0 && i < widget.pings.length) {
          ref.read(focusedPingIdProvider.notifier).state = widget.pings[i].id;
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant PingFocusList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the pings list has changed, we need to check if our focused ping has moved
    if (widget.pings != oldWidget.pings) {
      if (widget.pings.isEmpty) return;

      final focusedId = ref.read(focusedPingIdProvider);
      var newIndex = focusedId == null
          ? -1
          : widget.pings.indexWhere((p) => p.id == focusedId);

      // The focused ping left the list (e.g. it was hidden, or shown from the
      // hidden lens): stay at the same position, or the last one if the list
      // got shorter, and focus whichever ping is there now.
      if (newIndex == -1) {
        newIndex = i.clamp(0, widget.pings.length - 1);
        final newFocusedId = widget.pings[newIndex].id;
        // Providers can't be changed while the tree is building.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ref.read(focusedPingIdProvider.notifier).state = newFocusedId;
          }
        });
      }

      if (newIndex != i) {
        // Update local index
        setState(() {
          i = newIndex;
        });

        // Jump to the new page immediately to prevent visual jumping (flicker)
        // Doing this synchronously ensures the render phase uses the new position
        if (_pageController.hasClients) {
          _pageController.jumpToPage(newIndex);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // The lens page shows its empty state instead of this list.
    if (widget.pings.isEmpty) return const SizedBox.shrink();
    // Never read past the end, even for a frame while the list is changing.
    final current = widget.pings[min(i, widget.pings.length - 1)];

    return LayoutBuilder(builder: (context, constraints) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SystemRefresh(
            edgeOffset: -spacingSmall,
            onRefresh: () async {
              HapticFeedback.lightImpact();

              if (widget.pings.isNotEmpty && widget.pings.length > 1) {
                int newI = i;
                while (newI == i) {
                  newI = Random().nextInt(widget.pings.length);
                }

                final distance = (newI - i).abs();
                final duration = Duration(
                  milliseconds: (200 + (distance * 50)).clamp(200, 600),
                );

                _pageController.animateToPage(
                  newI,
                  duration: duration,
                  curve: Curves.easeOutCubic,
                );
              }
            },
            child: SingleChildScrollView(
                // Wrap Column in SingleChildScrollView to enable scrolling
                physics:
                    const AlwaysScrollableScrollPhysics(), // Disable bounce effect while keeping scrollable
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: fadeHeightTop,
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: spacingSmall),
                            child: SystemText(
                                text: PingDateUtils.formatForPing(
                                    widget.sortByResonance
                                        ? current.resonantTime!
                                        : widget.sortByPlaced && current.placedTime != null
                                            ? current.placedTime!
                                            : current.time))),
                        SizedBox(
                          height: MediaQuery.of(context).size.width -
                              spacingThree * 8,
                          child: PageView.builder(
                            reverse: true,
                            controller: _pageController,
                            itemCount: widget.pings.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: spacingThree),
                                child: PingCell(
                                  inputPing: widget.pings[i],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: spacingMedium,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final hideFocusButtons = ref.watch(hideFocusButtonsProvider);
                            return hideFocusButtons 
                                ? SizedBox.shrink() 
                                : PingActionRow(ping: current);
                          },
                        ),
                      ],
                    )))),
      ]);
    });
  }
}
