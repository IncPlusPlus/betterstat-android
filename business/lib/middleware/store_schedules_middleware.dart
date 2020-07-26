//import 'package:betterstatmobile_business_logic/actions/actions.dart';
//import 'package:betterstatmobile_business_logic/models/models.dart';
//import 'package:betterstatmobile_business_logic/repository/generic_future_repository.dart';
//import 'package:betterstatmobile_business_logic/repository/schedule_repository.dart';
//import 'package:betterstatmobile_business_logic/util/specialized_completer.dart';
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
//    createDeleteSchedule<T>(ScheduleRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//
//    return repository.deleteById(action.payload as String);
//  };
//}
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
//    createFetchSchedules<T>(ScheduleRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    var loadingCallback = action.payload as SpecializedCompleterTuple;
//    repository.getAll().then((schedules) {
//      loadingCallback.statusCompleter.complete();
//      return api.actions.loadSchedulesSuccess(schedules);
//    }).catchError((Object error, [StackTrace stackTrace]) {
//      loadingCallback.statusCompleter.completeError(error, stackTrace);
//      return api.actions.loadSchedulesFailure();
//    }).whenComplete(() => loadingCallback.completer.complete());
//    next(action);
//  };
//}
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
//    createSaveSchedule<T>(ScheduleRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//
//    repository.createById(action.payload as Schedule);
//  };
//}
//
//Middleware<AppState, AppStateBuilder, AppActions>
//    createStoreSchedulesMiddleware([
//  GenericFutureRepository<Schedule, String> repository =
//      const ScheduleRepository(),
//]) {
//  return (MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
//        ..add(AppActionsNames.fetchSchedulesAction,
//            createFetchSchedules<SpecializedCompleterTuple>(repository))
//        ..add(AppActionsNames.addScheduleAction,
//            createSaveSchedule<Schedule>(repository))
////        ..add(AppActionsNames.loadSchedulesSuccess,
////            createSaveSchedules<List<Schedule>>(repository))
//        ..add(AppActionsNames.deleteScheduleAction,
//            createDeleteSchedule<String>(repository))
//        ..add(AppActionsNames.updateScheduleAction,
//            createUpdateSchedule<UpdateScheduleActionPayload>(repository)))
//      .build();
//}
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
//    createUpdateSchedule<T>(ScheduleRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//    var pl = action.payload as UpdateScheduleActionPayload;
//
//    repository.saveById(pl.updatedSchedule, pl.id);
//  };
//}
//
////MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
////    createSaveSchedules<T>(SchedulesRepository repository) {
////  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
////      ActionHandler next, Action<T> action) {
////    next(action);
////
////    repository.saveSchedules(api.state.schedules.toList());
////  };
////}
