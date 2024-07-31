import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/date_time_enum_extensions.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key, required this.ping, required this.title});

  final Ping ping;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        TopNav(
          child: SystemButton(
              onTap: () => Navigator.pop(context),
              icon: PhosphorIcons.caret_left,
              text: title),
        ),
        SystemDivider(),
        AspectRatio(
            aspectRatio: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: FittedBox(
                        alignment: Alignment.topLeft,
                        fit: BoxFit.scaleDown,
                        child: SystemText(
                          text: "\"${ping.text}\"",
                          font: FontEnum.garamond,
                          size: TextSizeEnum.thirtySix,
                        ))),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: spacingFour, vertical: spacingFour),
                    child: Stack(
                      children: [
                        Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                              color: gray, shape: BoxShape.circle),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SystemText(
                            text: DateFormat('EEE MMM d, yyyy · h:mma')
                                .format(ping.time),
                            color: gray,
                          ),
                        ),
                      ],
                    ))
              ],
            )),
        SystemDivider(),
        Column(children: [
          NavigationCell(
              onTap: () {
                // Go to replies filter
              },
              label: "Replies",
              value: "5"),
          SystemDivider(),
          NavigationCell(
              onTap: () {
                // Go to time of day filter
              },
              label: "Time of Day",
              value: ping.time.themeMode().toString()),
          SystemDivider(),
          NavigationCell(
              onTap: () {
                // Go to time of day filter
              },
              label: "Day of Week",
              value: DateFormat('EEEE').format(ping.time)),
          SystemDivider(),
          NavigationCell(
              onTap: () {
                // Go to time of day filter
              },
              label: "Month",
              value: DateFormat('MMMM').format(ping.time)),
          SystemDivider(),
          NavigationCell(
              onTap: () {
                // Go to time of day filter
              },
              label: "Day",
              value: DateFormat('MMM d, yyyy').format(ping.time)),
          SystemDivider(),
        ])
      ],
    )));
  }
}
