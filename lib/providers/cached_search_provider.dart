import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'dart:async';

class CachedSearchNotifier extends AsyncNotifier<List<PingData>> {
  Timer? _debounceTimer;
  String _currentQuery = '';
  final Map<String, List<PingData>> _cache = {};

  @override
  Future<List<PingData>> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    
    return [];
  }

  void search(String query) {
    _debounceTimer?.cancel();
    
    if (query.trim().isEmpty) {
      _currentQuery = '';
      state = const AsyncValue.data([]);
      return;
    }

    if (_cache.containsKey(query)) {
      final cachedResults = _cache[query]!;
      if (!_areResultsEqual(state.valueOrNull ?? [], cachedResults)) {
        state = AsyncValue.data(cachedResults);
      }
      _currentQuery = query;
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 0), () async {
      if (query == _currentQuery) return;
      
      _currentQuery = query;
      
      if (state.valueOrNull == null || state.valueOrNull!.isEmpty) {
        state = const AsyncValue.loading();
      }
      
      try {
        final results = await performSearch(query);
        
        if (query == _currentQuery) {
          _cache[query] = results;
          
          if (!_areResultsEqual(state.valueOrNull ?? [], results)) {
            state = AsyncValue.data(results);
          }
        }
      } catch (error, stackTrace) {
        if (query == _currentQuery) {
          state = AsyncValue.error(error, stackTrace);
        }
      }
    });
  }

  bool _areResultsEqual(List<PingData> list1, List<PingData> list2) {
    if (list1.length != list2.length) return false;
    
    return const ListEquality().equals(list1, list2);
  }

  Future<List<PingData>> performSearch(String searchString) async {
    return ref.read(pingsMapProvider).when(
      data: (map) {
        final visiblePings = map.values.where((ping) => !ping.hidden);
        return visiblePings
            .where((ping) =>
                ping.text.toLowerCase().contains(searchString.toLowerCase()))
            .toList()
          ..sort((a, b) => b.time.compareTo(a.time));
      },
      loading: () => <PingData>[],
      error: (_, __) => <PingData>[],
    );
  }

  void clearCache() {
    _cache.clear();
  }
}

final cachedSearchProvider = AsyncNotifierProvider<CachedSearchNotifier, List<PingData>>(
  () => CachedSearchNotifier(),
);
