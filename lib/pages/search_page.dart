import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_search_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/search_string_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.all(spacingFour),
        child: Column(
          children: [
            TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(spacingFour),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) =>
                  ref.read(searchStringProvider.notifier).setSearch(value),
            ),
            SizedBox(
              height: spacingFive,
            ),
            Expanded(child: PingSearchList())
          ],
        ));
  }
}
