import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage(
      {super.key,
      required this.tabController,
      required this.tabs,
      required this.children});

  final TabController tabController;
  final List<String> tabs;
  final List<Widget> children;

  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.symmetric(vertical: spacingSmall),
          child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(),
              isScrollable: true,
              splashFactory: NoSplash.splashFactory,
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              tabs: tabs.map((tab) {
                return Text(
                  tab,
                  style: TextStyle(
                      fontSize: TextSizeEnum.twentyNine.toFontSize(),
                      fontFamily: FontEnum.sfpro.toFontFamily()),
                );
              }).toList())),
      Expanded(child: TabBarView(controller: tabController, children: children))
    ]);
  }
}
