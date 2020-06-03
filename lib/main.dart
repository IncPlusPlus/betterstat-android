import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/containers/add_schedule.dart';
import 'package:betterstatmobile/localization.dart';
import 'package:betterstatmobile/middleware/store_schedules_middleware.dart';
import 'package:betterstatmobile/models/app_state.dart';
import 'package:betterstatmobile/presentation/home_screen.dart';
import 'package:betterstatmobile/reducers/reducers.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:betterstatmobile/util/routes.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BetterstatApp());
}

class BetterstatApp extends StatefulWidget {
  final store = Store<AppState, AppStateBuilder, AppActions>(
    reducerBuilder.build(),
    AppState.loading(),
    AppActions(),
    middleware: [
      createStoreSchedulesMiddleware(),
    ],
  );

  @override
  State<StatefulWidget> createState() {
    return BetterstatAppState();
  }
}

class BetterstatAppState extends State<BetterstatApp> {
  Store<AppState, AppStateBuilder, AppActions> store;

  @override
  Widget build(BuildContext context) {
    return ReduxProvider(
      store: store,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Betterstat',
          theme: ThemeData.light(),
          localizationsDelegates: [
            const BetterstatLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            // The order of this list matters. By default, if the
            // device's locale doesn't exactly match a locale in
            // supportedLocales then the first locale in
            // supportedLocales with a matching
            // Locale.languageCode is used. If that fails then the
            // first locale in supportedLocales is used.
            const Locale('en'),
          ],
          routes: {
            BetterstatRoutes.home: (context) {
              return HomeScreen(key: BetterstatKeys.homeScreen);
            },
            BetterstatRoutes.addSchedule: (context) {
              return AddSchedule();
            },
          }),
    );
  }

  @override
  void initState() {
    store = widget.store;

    super.initState();
  }
}
