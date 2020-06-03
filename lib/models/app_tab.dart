library app_tab;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_tab.g.dart';

class AppTab extends EnumClass {
  static const AppTab schedules = _$schedules;

  static const AppTab stats = _$stats;

  static Serializer<AppTab> get serializer => _$appTabSerializer;

  static BuiltSet<AppTab> get values => _$appTabValues;

  const AppTab._(String name) : super(name);

  static AppTab fromIndex(int index) {
    switch (index) {
      case 1:
        return AppTab.stats;
      default:
        return AppTab.schedules;
    }
  }

  static int toIndex(AppTab tab) {
    switch (tab) {
      case AppTab.stats:
        return 1;
      default:
        return 0;
    }
  }

  static AppTab valueOf(String name) => _$appTabValueOf(name);
}
