import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/search_string_provider.dart';
import 'package:practice/repositories/pings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
Future<List<PingData>> search(Ref ref) async {
  final searchString = ref.watch(searchStringProvider);

  if (searchString.isEmpty) {
    return [];
  }

  final pingsList = await PingsRepository.search(searchString);

  return pingsList.map<PingData>((data) => PingData.fromJson(data)).toList();
}
