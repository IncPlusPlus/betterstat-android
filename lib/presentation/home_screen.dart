import 'package:betterstatmobile/containers/active_tab.dart';
import 'package:betterstatmobile/containers/schedules_tab.dart';
import 'package:betterstatmobile/containers/stats_tab.dart';
import 'package:betterstatmobile/containers/tab_selector.dart';
import 'package:betterstatmobile/localization.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:betterstatmobile/util/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(BetterstatLocalizations.of(context).appTitle),
          ),
          body: activeTab == AppTab.schedules ? SchedulesTab() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: BetterstatKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, BetterstatRoutes.addSchedule);
            },
            child: Icon(Icons.add),
            tooltip: BetterstatLocalizations.of(context).addSchedule,
          ),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}
