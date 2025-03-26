import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/ping_replies_provider.dart';

class RepliesGrid extends ConsumerWidget {
  const RepliesGrid({super.key, required this.pingId});

  final int pingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replies = ref.watch(pingRepliesProvider(pingId));

    return switch (replies) {
      AsyncData(value: final repliesValue) => repliesValue.isNotEmpty
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: spacingSix),
              SystemText(
                color: ref.watch(baseColorProvider).idInner,
                text: 'replies',
                size: TextSizeEnum.fifteen,
              ),
              Padding(
                  padding: EdgeInsets.only(top: spacingFive),
                  child: GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisSpacing: spacingThree,
                      mainAxisSpacing: spacingThree,
                      crossAxisCount: 2,
                      children: repliesValue.map((reply) {
                        return PingCell(
                          inputPing: reply,
                          showId: true,
                        );
                      }).toList()))
            ])
          : SizedBox.shrink(),
      _ => SizedBox.shrink()
    };
  }
}
