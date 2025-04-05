import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/components/ping_action_row.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_refresh.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/utils/ping_date_utils.dart';

class PingFocusList extends StatefulWidget {
  const PingFocusList({
    super.key,
    required this.pings,
    this.sortByResonance = false,
  });

  final List<PingData> pings;
  final bool sortByResonance;

  @override
  State<PingFocusList> createState() => _PingFocusListState();
}

class _PingFocusListState extends State<PingFocusList> {
  late PageController _pageController;

  int i = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.9);

    _pageController.addListener(() {
      int newI = _pageController.page!.round();

      if (i != newI)
        setState(() {
          i = _pageController.page!.round();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(builder: (context, constraints) {
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
                                        ? widget.pings[i].resonantTime!
                                        : widget.pings[i].time))),
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
                        PingActionRow(ping: widget.pings[i]),
                      ],
                    )))),
      ]);
    }));
  }
}
