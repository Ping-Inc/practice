import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/search_text_field.dart';
import 'package:practice/components/ping_search_list.dart';
import 'package:practice/components/header_min.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/constants.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              HeaderMin(),
              Expanded(
                  child: MainSpacingCell(
                      bottomPadding: false,
                      child: Column(
                        children: [
                          SearchTextField(),
                          SizedBox(
                            height: spacingMedium,
                          ),
                          Expanded(child: PingSearchList())
                        ],
                      )))
            ])));
  }
}
