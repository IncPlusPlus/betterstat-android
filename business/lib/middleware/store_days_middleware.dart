//import 'package:betterstatmobile_business_logic/actions/actions.dart';
//import 'package:betterstatmobile_business_logic/models/day.dart';
//import 'package:betterstatmobile_business_logic/models/models.dart';
//import 'package:betterstatmobile_business_logic/repository/day_repository.dart';
//import 'package:betterstatmobile_business_logic/repository/generic_future_repository.dart';
//import 'package:betterstatmobile_business_logic/util/specialized_completer.dart';
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T> createDeleteDay<T>(
//    DayRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//
//    return repository.deleteById(action.payload as String);
//  };
//}
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T> createFetchDays<T>(
//    DayRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    var loadingCallback = action.payload as SpecializedCompleterTuple;
//    repository.getAll().then((days) {
//      loadingCallback.statusCompleter.complete();
//      return api.actions.loadDaysSuccess(days);
//    }).catchError((Object error, [StackTrace stackTrace]) {
//      loadingCallback.statusCompleter.completeError(error, stackTrace);
//      return api.actions.loadDaysFailure();
//    }).whenComplete(() => loadingCallback.completer.complete());
//    next(action);
//  };
//}
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T> createSaveDay<T>(
//    DayRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//
//    repository.createById(action.payload as Day);
//  };
//}
//
//Middleware<AppState, AppStateBuilder, AppActions> createStoreDaysMiddleware([
//  GenericFutureRepository<Day, String> repository = const DayRepository(),
//]) {
//  return (MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
//        ..add(AppActionsNames.fetchDaysAction,
//            createFetchDays<SpecializedCompleterTuple>(repository))
//        ..add(AppActionsNames.addDayAction, createSaveDay<Day>(repository))
////        ..add(AppActionsNames.loadDaysSuccess,
////            createSaveDays<List<Day>>(repository))
//        ..add(AppActionsNames.deleteDayAction,
//            createDeleteDay<String>(repository))
//        ..add(AppActionsNames.updateDayAction,
//            createUpdateDay<UpdateDayActionPayload>(repository)))
//      .build();
//}
//
//MiddlewareHandler<AppState, AppStateBuilder, AppActions, T> createUpdateDay<T>(
//    DayRepository repository) {
//  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next, Action<T> action) {
//    next(action);
//    var pl = action.payload as UpdateDayActionPayload;
//
//    repository.saveById(pl.updatedDay, pl.id);
//  };
//}
//
////MiddlewareHandler<AppState, AppStateBuilder, AppActions, T>
////    createSaveDays<T>(DaysRepository repository) {
////  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
////      ActionHandler next, Action<T> action) {
////    next(action);
////
////    repository.saveDays(api.state.days.toList());
////  };
////}
