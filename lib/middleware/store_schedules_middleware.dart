import 'package:betterstatmobile/repository/SchedulesRepository.dart';
import 'package:built_redux/built_redux.dart';
import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/repository/WebRepository.dart';
import 'package:betterstatmobile/models/models.dart';

Middleware<AppState, AppStateBuilder, AppActions>
    createStoreSchedulesMiddleware([
  SchedulesRepository repository = const WebRepository(),
]) {
  return (MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
        ..add(AppActionsNames.fetchSchedulesAction,
            createFetchSchedules(repository))
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
    createDeleteSchedule<T>(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    next(action);

    return repository.deleteSchedule(action.payload as String);
  };
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
MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
    createSaveSchedule<T>(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    next(action);

    repository.createSchedule(action.payload as Schedule);
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, Null>
    createFetchSchedules(SchedulesRepository repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<Null> action) {
    if (api.state.isLoading) {
      repository.loadSchedules().then((schedules) {
        return api.actions.loadSchedulesSuccess(schedules);
      }).catchError(api.actions.loadSchedulesFailure);
    }

    next(action);
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
