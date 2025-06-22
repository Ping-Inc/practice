import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/providers/simple_saved_searches_provider.dart';

class ClearSavedSearchesCell extends ConsumerWidget {
  const ClearSavedSearchesCell({super.key});

  void _showSnackBar(BuildContext context, String message) {
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

  Future<void> _showClearConfirmation(BuildContext context, WidgetRef ref) async {
    final savedSearches = await ref.read(simpleSavedSearchesProvider.future);
    
    if (savedSearches.isEmpty) {
      if (context.mounted) {
        _showSnackBar(context, 'No saved searches to clear');
      }
      return;
    }

if (context.mounted) {
      final count = savedSearches.length;
      final searchText = count == 1 ? '1 saved search' : 'all $count saved searches';
      
      final shouldClear = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clear Saved Searches'),
          content: Text('Are you sure you want to delete $searchText?  This cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 158, 39, 25),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (shouldClear == true) {
        try {
          await ref.read(simpleSavedSearchesProvider.notifier).clearAllSavedSearches();
          if (context.mounted) {
            _showSnackBar(context, 'Saved searches cleared');
          }
        } catch (e) {
          if (context.mounted) {
            _showSnackBar(context, 'Failed to clear saved searches');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsActivationCell(
      text: "Clear All Saved Searches",
      onTap: () => _showClearConfirmation(context, ref),
    );
  }
}
