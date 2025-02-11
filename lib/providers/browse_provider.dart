import 'package:practice/constants.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browse_provider.g.dart';

@riverpod
class Browse extends _$Browse {
  @override
  BrowseEnum build() {
    String? mode = prefs.getString(sharedPrefsBrowseMode);

    return mode == null
        ? BrowseEnum.focus
        : BrowseEnum.values.firstWhere((e) => e.toString() == mode);
  }

  void setMode(BrowseEnum browse) {
    prefs.setString(sharedPrefsBrowseMode, browse.toString());
    state = browse;
  }
}
