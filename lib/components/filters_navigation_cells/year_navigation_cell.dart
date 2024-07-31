import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/extensions/time_filter_enum_extensions.dart';
import 'package:practice/pages/browse_time_page.dart';

class YearNavigationCell extends StatelessWidget {
  const YearNavigationCell({super.key, required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return NavigationCell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BrowseTimePage(
                        time: time,
                        timeEnum: TimeFilterEnum.year,
                      )),
            ),
        label: TimeFilterEnum.year.toTitle(),
        value: DateFormat(TimeFilterEnum.year.toDateFormat()).format(time));
  }
}
