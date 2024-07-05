import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/pages/details_page.dart';
import 'package:practice/providers/latest_ping_provider.dart';

class LastPingCell extends ConsumerWidget {
  const LastPingCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestPing = ref.watch(latestPingProvider);

    switch (latestPing) {
      case AsyncData(value: final latestPing):
        return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(ping: latestPing)),
              );
            },
            child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                    color: Colors.white,
                    child: ResizingTextCell(
                      text: latestPing!.text,
                    ))));
      default:
        return AspectRatio(
            aspectRatio: 1,
            child: Container(
                color: Colors.white, child: ResizingTextCell(text: "")));
    }
  }
}
