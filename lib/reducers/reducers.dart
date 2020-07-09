import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:built_redux/built_redux.dart';

var reducerBuilder = ReducerBuilder<AppState, AppStateBuilder>()
//TODO: We're removing the app's tab from the state
  ..add(AppActionsNames.updateTabAction, updateTab)
//<editor-fold desc="Schedule actions">
  ..add(AppActionsNames.addScheduleAction, addSchedule)
  ..add(AppActionsNames.deleteScheduleAction, deleteSchedule)
  ..add(AppActionsNames.updateScheduleAction, updateSchedule)
  ..add(AppActionsNames.loadSchedulesSuccess, schedulesLoaded)
  ..add(AppActionsNames.loadSchedulesFailure, schedulesLoadFailed)
//</editor-fold>
//<editor-fold desc="Day actions">
  ..add(AppActionsNames.addDayAction, addDay)
  ..add(AppActionsNames.deleteDayAction, deleteDay)
  ..add(AppActionsNames.updateDayAction, updateDay)
  ..add(AppActionsNames.loadDaysSuccess, daysLoaded)
  ..add(AppActionsNames.loadDaysFailure, daysLoadFailed);
//</editor-fold>

//TODO: This has gotta go too
void updateTab(AppState state, Action<AppTab> action, AppStateBuilder builder) {
  builder.activeTab = action.payload;
}

//<editor-fold desc="Schedule methods">
void addSchedule(
    AppState state, Action<Schedule> action, AppStateBuilder builder) {
  builder.schedules.add(action.payload);
}

void deleteSchedule(
    AppState state, Action<String> action, AppStateBuilder builder) {
  builder.schedules.where((schedule) => schedule.id != action.payload);
}

void schedulesLoaded(
    AppState state, Action<List<Schedule>> action, AppStateBuilder builder) {
  builder
    ..isLoading = false
    ..schedules.clear()
    ..schedules.addAll(action.payload);
}

void schedulesLoadFailed(
    AppState state, Action<Object> action, AppStateBuilder builder) {
  builder
    ..isLoading = false
    ..schedules.clear();
}

void updateSchedule(AppState state, Action<UpdateScheduleActionPayload> action,
    AppStateBuilder builder) {
  builder.schedules.map((schedule) =>
  schedule.id == action.payload.id
      ? action.payload.updatedSchedule
      : schedule);
}
//</editor-fold>
//<editor-fold desc="Day methods">
void addDay(AppState state, Action<Day> action, AppStateBuilder builder) {
  builder.days.add(action.payload);
}

void deleteDay(AppState state, Action<String> action, AppStateBuilder builder) {
  builder.days.where((day) => day.id != action.payload);
}

void daysLoaded(AppState state, Action<List<Day>> action,
    AppStateBuilder builder) {
  builder
    ..isLoading = false
    ..days.clear()
    ..days.addAll(action.payload);
}

void daysLoadFailed(AppState state, Action<Object> action,
    AppStateBuilder builder) {
  builder
    ..isLoading = false
    ..days.clear();
}

void updateDay(AppState state, Action<UpdateDayActionPayload> action,
    AppStateBuilder builder) {
  builder.days.map((day) =>
  day.id == action.payload.id
      ? action.payload.updatedDay
      : day);
}
//</editor-fold>