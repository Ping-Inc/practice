import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/search_string_provider.dart';
import 'package:practice/providers/search_provider.dart';
import 'package:practice/providers/cached_search_provider.dart';
import 'package:practice/providers/cached_search_setting_provider.dart';
import 'package:practice/providers/simple_saved_searches_provider.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({super.key});

  @override
  ConsumerState<SearchTextField> createState() => _PingEntryState();
}

class _PingEntryState extends ConsumerState<SearchTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveCurrentSearch() async {
    final currentText = controller.text.trim();
    if (currentText.isEmpty) return;

    try {
      final wasAdded = await ref.read(simpleSavedSearchesProvider.notifier).addSavedSearch(currentText);
      
      if (mounted) {
        if (wasAdded) {
          _showSnackBar('"$currentText" lens saved!');
        } else {
          _showSnackBar('Search "$currentText" already exists');
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Failed to save search');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchString = ref.watch(searchStringProvider);
    final useCachedSearch = ref.watch(cachedSearchSettingProvider);
    final savedSearches = ref.watch(simpleSavedSearchesProvider);
    
    final searchResults = useCachedSearch 
      ? ref.watch(cachedSearchProvider)
      : ref.watch(searchProvider);
    
    final showPlusButton = searchResults.when(
      data: (pings) => pings.length > 3,
      loading: () => false,
      error: (_, __) => false,
    );

    final currentSearchExists = savedSearches.when(
      data: (searches) => searches.any((search) => 
        search.toLowerCase() == searchString.trim().toLowerCase()),
      loading: () => false,
      error: (_, __) => false,
    );

    final isButtonActive = showPlusButton && !currentSearchExists && searchString.trim().isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: TextField(
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
                color: Theme.of(context).colorScheme.secondary,
              ),
              suffixIcon: searchString.isEmpty
                  ? null
                  : IconButton(
                      icon: Icon(PhosphorIcons.x_circle_fill,
                          color: Theme.of(context).colorScheme.secondary),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        ref.read(searchStringProvider.notifier).setSearch('');
                        
                        if (useCachedSearch) {
                          ref.read(cachedSearchProvider.notifier).search('');
                        }
                        
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
            onChanged: (value) {
              ref.read(searchStringProvider.notifier).setSearch(value);
              
              if (useCachedSearch) {
                ref.read(cachedSearchProvider.notifier).search(value);
              }
            },
          ),
        ),
        if (showPlusButton) ...[
          SizedBox(width: spacingSmall),
          GestureDetector(
            onTap: isButtonActive ? _saveCurrentSearch : null,
            child: SvgPicture.asset(
              'images/icons/create-lens.svg',
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                isButtonActive 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
