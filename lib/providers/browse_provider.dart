import 'package:practice/enums/browse_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browse_provider.g.dart';

@riverpod
class Browse extends _$Browse {
  @override
  BrowseEnum build() {
    return BrowseEnum.list;
  }

  void setTab(BrowseEnum browse) {
    state = browse;
  }
}
