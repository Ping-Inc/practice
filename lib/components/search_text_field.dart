import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/search_string_provider.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({super.key});

  @override
  ConsumerState<SearchTextField> createState() => _PingEntryState();
}

class _PingEntryState extends ConsumerState<SearchTextField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchString = ref.watch(searchStringProvider);

    return TextField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        prefixIcon: Icon(
          PhosphorIcons.magnifying_glass,
          color: themeGray,
        ),
        suffixIcon: searchString.isEmpty
            ? null
            : IconButton(
                icon: Icon(PhosphorIcons.x_circle_fill, color: themeGray),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  ref.read(searchStringProvider.notifier).setSearch('');
                  controller.clear();
                },
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
    );
  }
}
