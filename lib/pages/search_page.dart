import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_search_list.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/providers/search_string_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Padding(
                padding: EdgeInsets.all(spacingFour),
                child: Column(
                  children: [
                    SystemButton(
                      onTap: () => Navigator.pop(context),
                      icon: PhosphorIcons.caret_left,
                    ),
                    SizedBox(
                      height: spacingFour,
                    ),
                    TextField(
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
                      onChanged: (value) => ref
                          .read(searchStringProvider.notifier)
                          .setSearch(value),
                    ),
                    SizedBox(
                      height: spacingFive,
                    ),
                    Expanded(child: PingSearchList())
                  ],
                ))));
  }
}
