library actions;

import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/util/specialized_completer.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'actions.g.dart';

abstract class AppActions implements ReduxActions {
  ActionDispatcher<AppTab> updateTabAction;

  //<editor-fold desc="Schedule">
  ActionDispatcher<Schedule> addScheduleAction;
  ActionDispatcher<String> deleteScheduleAction;
  ActionDispatcher<SpecializedCompleterTuple> fetchSchedulesAction;
  ActionDispatcher<List<Schedule>> loadSchedulesSuccess;
  ActionDispatcher<Object> loadSchedulesFailure;
  ActionDispatcher<UpdateScheduleActionPayload> updateScheduleAction;

  //</editor-fold>
  //<editor-fold desc="Day">
  ActionDispatcher<Day> addDayAction;
  ActionDispatcher<String> deleteDayAction;
  ActionDispatcher<SpecializedCompleterTuple> fetchDaysAction;
  ActionDispatcher<List<Day>> loadDaysSuccess;
  ActionDispatcher<Object> loadDaysFailure;
  ActionDispatcher<UpdateDayActionPayload> updateDayAction;

  //</editor-fold>

  factory AppActions() => _$AppActions();

  AppActions._();
}

abstract class UpdateScheduleActionPayload
    implements
        Built<UpdateScheduleActionPayload, UpdateScheduleActionPayloadBuilder> {
  static Serializer<UpdateScheduleActionPayload> get serializer =>
      _$updateScheduleActionPayloadSerializer;

  factory UpdateScheduleActionPayload(String id, Schedule updatedSchedule) =>
      _$UpdateScheduleActionPayload._(
        id: id,
        updatedSchedule: updatedSchedule,
      );

  UpdateScheduleActionPayload._();

  String get id;

  Schedule get updatedSchedule;
}

abstract class UpdateDayActionPayload
    implements Built<UpdateDayActionPayload, UpdateDayActionPayloadBuilder> {
  static Serializer<UpdateDayActionPayload> get serializer =>
      _$updateDayActionPayloadSerializer;

  factory UpdateDayActionPayload(String id, Day updatedDay) =>
      _$UpdateDayActionPayload._(
        id: id,
        updatedDay: updatedDay,
      );

  UpdateDayActionPayload._();

  String get id;

  Day get updatedDay;
}
