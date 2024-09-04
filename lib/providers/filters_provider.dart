import 'package:practice/enums/filters_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filters_provider.g.dart';

@riverpod
class Filters extends _$Filters {
  @override
  FiltersEnum build() {
    return FiltersEnum.all_pings;
  }

  void setTab(FiltersEnum browse) {
    state = browse;
  }
}
