import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/text_size_enum.dart';
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
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            backgroundColor: Theme.of(context)
                .scaffoldBackgroundColor, // Make the background transparent
            toolbarHeight: spacingFour, // Remove the unused top area
            bottom: TabBar(
              controller: tabController,
              indicator: BoxDecoration(),
              isScrollable: true,
              dividerColor: Colors.transparent, // Remove the divider color
              splashFactory: NoSplash.splashFactory, // Remove splash effect
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              tabs: tabs.map((tab) {
                return Text(
                  tab,
                  style:
                      TextStyle(fontSize: TextSizeEnum.twentyNine.toFontSize()),
                );
              }).toList(),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: children,
      ),
    );
  }
}
