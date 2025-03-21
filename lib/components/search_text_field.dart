import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/search_string_provider.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({super.key});

  @override
  ConsumerState<SearchTextField> createState() => _PingEntryState();
}

class _PingEntryState extends ConsumerState<SearchTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final searchString = ref.watch(searchStringProvider);

    return TextField(
      focusNode: focusNode,
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        prefixIcon: Icon(
          PhosphorIcons.magnifying_glass,
          color: ref.watch(baseColorProvider).secondary,
        ),
        suffixIcon: searchString.isEmpty
            ? null
            : IconButton(
                icon: Icon(PhosphorIcons.x_circle_fill,
                    color: ref.watch(baseColorProvider).secondary),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  ref.read(searchStringProvider.notifier).setSearch('');
                  controller.clear();
                  focusNode.requestFocus();
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
