import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'simple_saved_searches_provider.g.dart';

@riverpod
class SimpleSavedSearches extends _$SimpleSavedSearches {
  static const String _storageKey = 'saved_searches_simple';

  @override
  Future<List<String>> build() async {
    return await _loadSavedSearches();
  }

  Future<List<String>> _loadSavedSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_storageKey) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveSavedSearches(List<String> searches) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, searches);
  }

  Future<bool> addSavedSearch(String query) async {
    if (query.trim().isEmpty) return false;

    final currentSearches = await future;
    final trimmedQuery = query.trim();
    
    if (currentSearches.any((search) => 
        search.toLowerCase() == trimmedQuery.toLowerCase())) {
      return false;
    }

    final updatedSearches = [trimmedQuery, ...currentSearches];
    await _saveSavedSearches(updatedSearches);
    
    state = AsyncData(updatedSearches);
    return true;
  }

  Future<void> removeSavedSearch(String query) async {
    final currentSearches = await future;
    final updatedSearches = currentSearches
        .where((search) => search != query)
        .toList();
    
    await _saveSavedSearches(updatedSearches);
    state = AsyncData(updatedSearches);
  }

  Future<void> clearAllSavedSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    state = const AsyncData([]);
  }
}
