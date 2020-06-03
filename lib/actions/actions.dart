library actions;

import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/specialized_completer.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'actions.g.dart';

abstract class AppActions implements ReduxActions {
  ActionDispatcher<Schedule> addScheduleAction;
  ActionDispatcher<String> deleteScheduleAction;
  ActionDispatcher<SpecializedCompleterTuple> fetchSchedulesAction;
  ActionDispatcher<List<Schedule>> loadSchedulesSuccess;
  ActionDispatcher<Object> loadSchedulesFailure;
  ActionDispatcher<AppTab> updateTabAction;
  ActionDispatcher<UpdateScheduleActionPayload> updateScheduleAction;

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
