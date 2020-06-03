import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/repository/SchedulesRepository.dart';
import 'package:betterstatmobile/repository/WebRepository.dart';
import 'package:betterstatmobile/util/specialized_completer.dart';
import 'package:built_redux/built_redux.dart';

MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
    createDeleteSchedule<T>(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    next(action);

    return repository.deleteSchedule(action.payload as String);
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
    createFetchSchedules<T>(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    var loadingCallback = action.payload as SpecializedCompleterTuple;
    repository.loadSchedules().then((schedules) {
      loadingCallback.statusCompleter.complete();
      return api.actions.loadSchedulesSuccess(schedules);
    }).catchError((Object error, [StackTrace stackTrace]) {
      loadingCallback.statusCompleter.completeError(error, stackTrace);
      return api.actions.loadSchedulesFailure();
    }).whenComplete(() => loadingCallback.completer.complete());
    next(action);
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
    createSaveSchedule<T>(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    next(action);

    repository.createSchedule(action.payload as Schedule);
  };
}

Middleware<AppState, AppStateBuilder, AppActions>
    createStoreSchedulesMiddleware([
  SchedulesRepository repository = const WebRepository(),
]) {
  return (MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
        ..add(AppActionsNames.fetchSchedulesAction,
            createFetchSchedules<SpecializedCompleterTuple>(repository))
        ..add(AppActionsNames.addScheduleAction,
            createSaveSchedule<Schedule>(repository))
//        ..add(AppActionsNames.loadSchedulesSuccess,
//            createSaveSchedules<List<Schedule>>(repository))
        ..add(AppActionsNames.deleteScheduleAction,
            createDeleteSchedule<String>(repository))
        ..add(AppActionsNames.updateScheduleAction,
            createUpdateSchedule<UpdateScheduleActionPayload>(repository)))
      .build();
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
    createUpdateSchedule<T>(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    next(action);
    var pl = action.payload as UpdateScheduleActionPayload;

    repository.saveSchedule(pl.updatedSchedule, pl.id);
  };
}

//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
//    createSaveSchedules<T>(SchedulesRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//
//    repository.saveSchedules(api.state.schedules.toList());
//  };
//}
