import 'package:built_redux/built_redux.dart';
import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';

var reducerBuilder = ReducerBuilder<AppState, AppStateBuilder>()
  ..add(AppActionsNames.addScheduleAction, addSchedule)
  ..add(AppActionsNames.deleteScheduleAction, deleteSchedule)
  ..add(AppActionsNames.updateTabAction, updateTab)
  ..add(AppActionsNames.updateScheduleAction, updateSchedule)
  ..add(AppActionsNames.loadSchedulesSuccess, schedulesLoaded)
  ..add(AppActionsNames.loadSchedulesFailure, schedulesLoadFailed);

void addSchedule(AppState state, Action<Schedule> action, AppStateBuilder builder) {
  builder.schedules.add(action.payload);
}

void deleteSchedule(
    AppState state, Action<String> action, AppStateBuilder builder) {
  builder.schedules.where((schedule) => schedule.id != action.payload);
}

void updateTab(AppState state, Action<AppTab> action, AppStateBuilder builder) {
  builder.activeTab = action.payload;
}

void schedulesLoaded(
    AppState state, Action<List<Schedule>> action, AppStateBuilder builder) {
  builder
    ..isLoading = false
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
      schedule.id == action.payload.id ? action.payload.updatedSchedule : schedule);
}