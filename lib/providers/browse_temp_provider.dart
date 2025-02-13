import 'package:practice/enums/browse_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browse_temp_provider.g.dart';

@riverpod
class BrowseTemp extends _$BrowseTemp {
  @override
  BrowseEnum? build() {
    return null;
  }

  void setMode(BrowseEnum browse) {
    if (state != browse) {
      state = browse;
    }
  }
}
