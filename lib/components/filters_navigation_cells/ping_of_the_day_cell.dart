import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/pages/details_page.dart';
import 'package:practice/providers/ping_of_the_day_provider.dart';
import 'package:practice/providers/time_provider.dart';

class PingOfTheDayCell extends ConsumerWidget {
  const PingOfTheDayCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(timeProvider, (previous, next) {
      if (previous != null &&
          previous.value != null &&
          next.value != null &&
          previous.value!.day != next.value!.day) {
        ref.invalidate(pingOfTheDayProvider);
      }
    });

    final pingOfTheDay = ref.watch(pingOfTheDayProvider);

    return switch (pingOfTheDay) {
      AsyncData(value: final pingOfTheDayValue) => NavigationCell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(ping: pingOfTheDayValue)),
              ),
          label: "Ping of the Day",
          value: "\"${pingOfTheDayValue.text}\""),
      _ => SizedBox.shrink()
    };
  }
}
