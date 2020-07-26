import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/containers/add_day.dart';
import 'package:betterstatmobile_client_components/containers/add_schedule.dart';
import 'package:betterstatmobile_client_components/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Store<AppState> store;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  store = Store<AppState>(initialState: AppState.initialState());
  runApp(BetterstatApp());
}

///To rebuild or edit the translations, follow the directions at these two links
///https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl
///https://localizely.com/flutter-localization-workflow/
///One could use Loco or Localizely
class BetterstatApp extends StatelessWidget {
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
            }),
      );
}
