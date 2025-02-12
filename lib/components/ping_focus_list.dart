import 'package:flutter/material.dart';
import 'package:practice/components/ping_action_row.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/utils/date_format_utils.dart';

class PingFocusList extends StatefulWidget {
  const PingFocusList({super.key, required this.pings, required this.scroll});

  final List<PingData> pings;
  final VoidCallback scroll;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: spacingSmall),
            child: SystemText(
                text: DateFormatUtils.formatForPing(widget.pings[i].time))),
        SizedBox(
          height: MediaQuery.of(context).size.width,
          child: PageView.builder(
            reverse: true,
            controller: _pageController,
            itemCount: widget.pings.length,
            itemBuilder: (context, i) {
              if (i == widget.pings.length - 1 &&
                  widget.pings.length % fetchLimit == 0) {
                widget.scroll();
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingThree),
                child: PingCell(
                  inputPing: widget.pings[i],
                  showId: true,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: spacingSmall,
        ),
        PingActionRow(ping: widget.pings[i]),
      ],
    );
  }
}
