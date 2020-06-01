// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You can read about packages here: https://flutter.io/using-packages/
import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/containers/add_schedule.dart';
import 'package:betterstatmobile/localization.dart';
import 'package:betterstatmobile/middleware/store_schedules_middleware.dart';
import 'package:betterstatmobile/models/app_state.dart';
import 'package:betterstatmobile/presentation/home_screen.dart';
import 'package:betterstatmobile/reducers/reducers.dart';
import 'package:betterstatmobile/schedules_page.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:betterstatmobile/util/routes.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The function that is called when main.dart is run.
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
  void initState() {
    store = widget.store;

    store.actions.fetchSchedulesAction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReduxProvider(
      store: store,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Thing',
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
}
