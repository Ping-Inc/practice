import 'package:practice/enums/sub_pages_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_provider.g.dart';

@riverpod
class Tab extends _$Tab {
  @override
  SubPagesEnum build() {
    return SubPagesEnum.browse;
  }

  void setTab(SubPagesEnum tab) {
    state = tab;
  }
}
