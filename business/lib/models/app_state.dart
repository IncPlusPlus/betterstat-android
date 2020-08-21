library app_state;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/models/app_tab.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/schedule.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/models/thermostat_setup_status.dart';
import 'package:betterstatmobile_business_logic/util/optional.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  factory AppState([void Function(AppStateBuilder b) updates]) =>
      _$AppState((b) => b
        ..wait = Wait()
        ..thermostats = ListBuilder<Thermostat>([])
        ..days = ListBuilder<Day>([])
        ..schedules = ListBuilder<Schedule>([])
        ..activeTab = AppTab.schedules
        ..ports = ListBuilder<DescriptivePortNameSystemPortNamePair>([])
        ..thermostatSetupMap = MapBuilder<String, ThermostatSetupStatus>({})
        ..update(updates));

  factory AppState.fromSchedules(List<Schedule> schedules) =>
      AppState((b) => b..schedules = ListBuilder<Schedule>(schedules));

  AppState._();

  AppTab get activeTab;

  Wait get wait;

  @memoized
  int get numActiveSelector => 2;

  @memoized
  int get numCompletedSelector => 10;

  BuiltList<Thermostat> get thermostats;

  BuiltList<Day> get days;

  BuiltList<Schedule> get schedules;

  BuiltList<DescriptivePortNameSystemPortNamePair> get ports;

  BuiltMap<String, ThermostatSetupStatus> get thermostatSetupMap;

  //TODO: Is memoization necessary?
  @memoized
  List<Thermostat> get thermostatsSelector => thermostats.toList();

  @memoized
  List<DescriptivePortNameSystemPortNamePair> get portsSelector =>
      ports.toList();

  @memoized
  List<Day> get daysSelector => days.toList();

  @memoized
  List<Schedule> get schedulesSelector => schedules.toList();

  Optional<Schedule> scheduleSelector(String id) {
    try {
      return Optional.of(schedules.firstWhere((schedule) => schedule.id == id));
    } catch (e) {
      return Optional.absent();
    }
  }

  static AppState initialState() => AppState((b) => b.build());
}
