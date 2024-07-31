import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/pages/details_page.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/search_provider.dart';

class PingSearchList extends ConsumerWidget {
  const PingSearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pings = ref.watch(searchProvider);

    return switch (pings) {
      AsyncData(value: final pingsValue) => ListView.separated(
          itemCount: pingsValue.length,
          separatorBuilder: (context, index) => SizedBox(
            height: spacingThree,
          ),
          itemBuilder: (context, i) {
            final ping = pingsValue[i];

            if (i == pingsValue.length - 1 &&
                pingsValue.length % fetchLimit == 0) {
              ref.read(pingsProvider.notifier).scroll();
            }

            return SystemTap(
                child: PingCell(ping: ping, mode: BrowseEnum.list),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(ping: ping, title: "Search")),
                  );
                });
          },
        ),
      AsyncError() => SystemText(text: "Error"),
      _ => SizedBox.shrink()
    };
  }
}
