import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/api/exceptions.dart';
import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/day/connector/add_day.dart';
import 'package:betterstatmobile_client_components/presentation/home_screen.dart';
import 'package:betterstatmobile_client_components/schedule/connector/add_schedule.dart';
import 'package:betterstatmobile_client_components/thermostat/connector/add_thermostat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var store = Store<AppState>(
    initialState: AppState.initialState(),
    wrapError: MyWrapError(),
  );
  runApp(BetterstatApp(store: store));
}

class MyWrapError extends WrapError {
  @override
  UserException wrap(Object error, StackTrace stackTrace, ReduxAction action) {
    if (error is UnexpectedResponseException) {
      return UserException(
          'Communication error with server. Expected response code ${error.expectedCode} but got ${error.resultCode}.'
          '\n\nResponse from server:\n${error.responseBody}',
          cause: error);
    } else {
      return null;
    }
  }
}

///To rebuild or edit the translations, follow the directions at these two links
///https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl
///https://localizely.com/flutter-localization-workflow/
///One could use Loco or Localizely
class BetterstatApp extends StatelessWidget {
  final Store<AppState> store;

  BetterstatApp({Key key, @required this.store})
      : assert(store != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Betterstat',
            theme: ThemeData.light(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routes: {
              BetterstatRoutes.home: (context) {
                return HomeScreen(key: BetterstatKeys.homeScreen);
              },
              BetterstatRoutes.addSchedule: (context) {
                return AddSchedule();
              },
              BetterstatRoutes.addDay: (context) {
                return AddDay();
              },
              BetterstatRoutes.addThermostat: (context) {
                return AddThermostat();
              },
            }),
      );
}
