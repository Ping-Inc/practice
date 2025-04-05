import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/utils/ping_date_utils.dart';

class PingFocusList extends ConsumerStatefulWidget {
  const PingFocusList({
    super.key,
    required this.pings,
    this.sortByResonance = false,
  });

  final List<PingData> pings;
  final bool sortByResonance;

  @override
  ConsumerState<PingFocusList> createState() => _PingFocusListState();
}

class _PingFocusListState extends ConsumerState<PingFocusList> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPage = widget.pings.length - 1;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: fadeHeightTop),
                      Padding(
                        padding: EdgeInsets.only(bottom: spacingSmall),
                        child: SystemText(
                          text: PingDateUtils.formatForPing(
                            widget.sortByResonance
                                ? widget.pings[_currentPage].resonantTime!
                                : widget.pings[_currentPage].time,
                          ),
                        ),
                      ),
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
                                horizontal: spacingThree,
                              ),
                              child: PingCell(
                                inputPing: widget.pings[i],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
