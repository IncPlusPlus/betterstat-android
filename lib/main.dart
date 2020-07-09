import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/middleware/store_days_middleware.dart';
import 'package:betterstatmobile_business_logic/middleware/store_schedules_middleware.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/reducers/reducers.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/containers/add_day.dart';
import 'package:betterstatmobile_client_components/containers/add_schedule.dart';
import 'package:betterstatmobile_client_components/presentation/home_screen.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BetterstatApp());
}

///To rebuild or edit the translations, follow the directions at these two links
///https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl
///https://localizely.com/flutter-localization-workflow/
///One could use Loco or Localizely
class BetterstatApp extends StatefulWidget {
  final store = Store<AppState, AppStateBuilder, AppActions>(
    reducerBuilder.build(),
    AppState.loading(),
    AppActions(),
    middleware: [
      createStoreSchedulesMiddleware(),
      createStoreDaysMiddleware(),
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
          }),
    );
  }

  @override
  void initState() {
    store = widget.store;

    super.initState();
  }
}
