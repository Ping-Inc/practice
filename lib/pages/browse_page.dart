import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowsePage extends ConsumerStatefulWidget {
  const BrowsePage(
      {super.key,
      required this.asyncPings,
      required this.scroll,
      required this.count,
      required this.sliver});

  final AsyncValue<List<PingData>> asyncPings;
  final VoidCallback scroll;
  final int count;
  final bool sliver;

  @override
  ConsumerState<BrowsePage> createState() => _BrowserPageState();
}

class _BrowserPageState extends ConsumerState<BrowsePage> {
  late final PageController browseController;
  late final CardSwiperController swipeController;
  late final ScrollController listController;

  @override
  void initState() {
    super.initState();

    browseController =
        PageController(initialPage: ref.read(browseProvider).index);
    swipeController = CardSwiperController();
    listController = ScrollController();
  }

  @override
  Widget build(BuildContext contex) {
    return widget.count == 0
        ? widget.sliver
            ? SliverToBoxAdapter(
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: spacingSix),
                        child: SystemText(text: 'No pings match this filter'))),
              )
            : Center(child: SystemText(text: 'No pings match this filter'))
        : PingList(
            sliver: widget.sliver,
            scroll: widget.scroll,
            asyncPings: widget.asyncPings);
  }
}
