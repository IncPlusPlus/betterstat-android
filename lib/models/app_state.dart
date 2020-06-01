library app_state;

import 'package:betterstatmobile/models/app_tab.dart';
import 'package:betterstatmobile/models/schedule.dart';
import 'package:betterstatmobile/util/optional.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  bool get isLoading;

  BuiltList<Schedule> get schedules;

  AppTab get activeTab;

//  List<Thermostat> get thermostats;
  AppState._();

  factory AppState([void Function(AppStateBuilder b) updates]) =>
      _$AppState((b) => b
        ..isLoading = false
        ..schedules = ListBuilder<Schedule>([])
        ..activeTab = AppTab.schedules
        ..update(updates));

  factory AppState.loading() => AppState((b) => b..isLoading = true);

  factory AppState.fromSchedules(List<Schedule> schedules) =>
      AppState((b) => b..schedules = ListBuilder<Schedule>(schedules));

  @memoized
  int get numCompletedSelector => 10;

  @memoized
  int get numActiveSelector => 2;

  @memoized
  List<Schedule> get schedulesSelector => schedules.toList();

  Optional<Schedule> scheduleSelector(String id) {
    try {
      return Optional.of(schedules.firstWhere((schedule) => schedule.id == id));
    } catch (e) {
      return Optional.absent();
    }
  }
}
