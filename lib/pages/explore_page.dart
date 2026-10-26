import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/fade.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/providers/app_mode_provider.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.children,
    this.backArrow
  });

  final TabController tabController;
  final List<String> tabs;
  final List<Widget> children;
  final Widget? backArrow;

  // Matches the TabBar below: 30pt padding on each side, and each tab's
  // label plus Flutter's default 16pt on either side of it.
  static const double _rowPadding = spacingMedium * 2;
  static const double _tabPadding = 16 * 2;

  /// How wide the home lens tabs are when laid out side by side.
  double _tabRowWidth(BuildContext context) {
    final style = TextStyle(
        fontSize: TextSizeEnum.twentyNine.toFontSize(),
        fontFamily: FontEnum.sfpro.toFontFamily());
    final scaler = MediaQuery.textScalerOf(context);
    var width = _rowPadding;
    for (final tab in tabs) {
      final painter = TextPainter(
        text: TextSpan(text: tab, style: style),
        textDirection: TextDirection.ltr,
        textScaler: scaler,
      )..layout();
      width += painter.width + _tabPadding;
    }
    // Rounded up so a row that fits never scrolls.
    return width.ceilToDouble();
  }

  Widget build(BuildContext context, WidgetRef ref) {
    // The home lens tabs get a small PUBLIC label above them in public mode.
    final showPublicLabel = backArrow == null && ref.watch(isPublicModeProvider);

    return Column(children: [
      if (showPublicLabel)
        Padding(
          padding: EdgeInsets.only(top: spacingXSmall),
          child: Text(
            'PUBLIC',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              fontFamily: FontEnum.sfpro.toFontFamily(),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      Container(
        padding: EdgeInsets.only(top: spacingSmall),
        child: backArrow != null 
          ? Row(
              children: [
                backArrow!,
                Expanded(
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    controller: tabController,
                    isScrollable: true,
                    splashFactory: NoSplash.splashFactory,
                    dividerColor: Colors.transparent,
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: (value) {},
                    tabs: tabs.map((tab) {
                      return Text(
                        tab,
                        style: TextStyle(
                          fontSize: TextSizeEnum.twentyNine.toFontSize(),
                          fontFamily: FontEnum.sfpro.toFontFamily(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          // When the lens tabs don't fill the width, they line up on the
          // right, so "all pings" stays in the same spot however few lenses
          // there are. When they do fill it, the row scrolls as before.
          : LayoutBuilder(builder: (context, constraints) {
              final width = _tabRowWidth(context);
              return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
              width: width < constraints.maxWidth ? width : constraints.maxWidth,
              child: TabBar(
              padding: EdgeInsets.only(right: spacingMedium, left: spacingMedium),
              // No extra gap before the first tab, so a short row can line
              // up with the edge.
              tabAlignment: TabAlignment.start,
              controller: tabController,
              isScrollable: true,
              splashFactory: NoSplash.splashFactory,
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: (value) {},
              tabs: tabs.map((tab) {
                return Text(
                  tab,
                  style: TextStyle(
                      fontSize: TextSizeEnum.twentyNine.toFontSize(),
                      fontFamily: FontEnum.sfpro.toFontFamily()),
                );
              }).toList(),
            )));
            }),
      ),
      Expanded(
        child: Stack(
          children: [
            TabBarView(
                controller: tabController,
                children: children),
            Align(alignment: Alignment.topCenter, child: Fade(topDown: true)),
          ],
        ),
      )
    ]);
  }
}
