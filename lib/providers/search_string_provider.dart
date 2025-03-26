import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_string_provider.g.dart';

@riverpod
class SearchString extends _$SearchString {
  @override
  String build() {
    return '';
  }

  void setSearch(String search) {
    state = search;
  }
}
