import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/repository/day_repository.dart';
import 'package:betterstatmobile_business_logic/repository/generic_future_repository.dart';
import 'package:betterstatmobile_business_logic/repository/schedule_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

ScheduleRepository _scheduleRepository = const ScheduleRepository();
GenericFutureRepository<Day, String> _dayRepository = const DayRepository();

class UpdateTabAction extends ReduxAction<AppState> {
  final AppTab newTab;

  UpdateTabAction.name({@required this.newTab}) : assert(newTab != null);

  @override
  AppState reduce() {
    return state.rebuild((b) => b..activeTab = newTab);
  }
}

class AddScheduleAction extends ReduxAction<AppState> {
  final Schedule newSchedule;

  AddScheduleAction({@required this.newSchedule}) : assert(newSchedule != null);

  @override
  Future<AppState> reduce() async {
    var createdSchedule = await _scheduleRepository.createById(newSchedule);
    assert(createdSchedule != null);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Sunday, newSchedule.sunday.id);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Monday, newSchedule.monday.id);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Tuesday, newSchedule.tuesday.id);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Wednesday, newSchedule.wednesday.id);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Thursday, newSchedule.thursday.id);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Friday, newSchedule.friday.id);
    await _scheduleRepository.setDayOfWeekToDay(
        createdSchedule.id, DayOfWeek.Saturday, newSchedule.saturday.id);
    var finishedSchedule =
        await _scheduleRepository.getById(createdSchedule.id);
    return state.rebuild((b) async => b
      ..schedules =
          state.schedules.rebuild((b) => b.add(finishedSchedule)).toBuilder());
  }
}

class DeleteScheduleAction extends ReduxAction<AppState> {
  final String scheduleId;

  DeleteScheduleAction({@required this.scheduleId})
      : assert(scheduleId != null);

  @override
  Future<AppState> reduce() async {
    var deletedSchedule = await _scheduleRepository.deleteById(scheduleId);
    return state.rebuild((b) => b
      ..schedules = state.schedules
          .rebuild((b) => b.remove(deletedSchedule))
          .toBuilder());
  }
}

class FetchSchedulesAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    var newList = await _scheduleRepository.getAll();
    return state.rebuild(
        (b) => b..schedules = BuiltList<Schedule>.from(newList).toBuilder());
  }
}

class UpdateScheduleAction extends ReduxAction<AppState> {
  final Schedule originalSchedule;
  final Schedule updatedSchedule;

  UpdateScheduleAction(
      {@required this.updatedSchedule, @required this.originalSchedule})
      : assert(updatedSchedule != null),
        assert(originalSchedule != null);

  @override
  Future<AppState> reduce() async {
    var savedUpdatedSchedule = await _scheduleRepository.saveById(
        updatedSchedule, originalSchedule.id);
    return state.rebuild((b) => b
      ..schedules = state.schedules
          .rebuild((b) => b
            ..remove(originalSchedule)
            ..add(savedUpdatedSchedule))
          .toBuilder());
  }
}

class AddDayAction extends ReduxAction<AppState> {
  final Day newDay;

  AddDayAction({@required this.newDay}) : assert(newDay != null);

  @override
  Future<AppState> reduce() async {
    var createdDay = await _dayRepository.createById(newDay);
    return state.rebuild((b) async =>
        b..days = state.days.rebuild((b) => b.add(createdDay)).toBuilder());
  }
}

class DeleteDayAction extends ReduxAction<AppState> {
  final String dayId;

  DeleteDayAction({@required this.dayId}) : assert(dayId != null);

  @override
  Future<AppState> reduce() async {
    var deletedDay = await _dayRepository.deleteById(dayId);
    return state.rebuild((b) =>
        b..days = state.days.rebuild((b) => b.remove(deletedDay)).toBuilder());
  }
}

class FetchDaysAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    var newList = await _dayRepository.getAll();
    return state
        .rebuild((b) => b..days = BuiltList<Day>.from(newList).toBuilder());
  }
}

class UpdateDayAction extends ReduxAction<AppState> {
  final Day originalDay;
  final Day updatedDay;

  UpdateDayAction({@required this.updatedDay, @required this.originalDay})
      : assert(updatedDay != null),
        assert(originalDay != null);

  @override
  Future<AppState> reduce() async {
    var savedUpdatedDay =
        await _dayRepository.saveById(updatedDay, originalDay.id);
    return state.rebuild((b) => b
      ..days = state.days
          .rebuild((b) => b
            ..remove(originalDay)
            ..add(savedUpdatedDay))
          .toBuilder());
  }
}
