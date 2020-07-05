import 'package:betterstatmobile/containers/active_tab.dart';
import 'package:betterstatmobile/containers/days_tab.dart';
import 'package:betterstatmobile/containers/schedules_tab.dart';
import 'package:betterstatmobile/containers/stats_tab.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).appTitle),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Thermostats',
                    icon: Icon(MaterialCommunityIcons.thermostat),
                  ),
                  Tab(
                    text: 'Schedules',
                    icon: Icon(Icons.calendar_today),
                  ),
                  Tab(
                    text: 'Days',
                    icon: Icon(Icons.view_day),
                  ),
                  Tab(
                    text: 'Stats',
                    icon: Icon(Icons.directions_bike),
                  ),
                ],
              ),
            ),
//          body: activeTab == AppTab.schedules ? SchedulesTab() : Stats(),
            body: TabBarView(children: [
              Icon(Icons.directions_car),
              SchedulesTab(),
              DaysTab(),
              Stats(),
            ]),
//          floatingActionButton: FloatingActionButton(
//            key: BetterstatKeys.addScheduleFab,
//            onPressed: () {
//              Navigator.pushNamed(context, BetterstatRoutes.addSchedule);
//            },
//            child: Icon(Icons.add),
//            tooltip: S.of(context).addSchedule,
//          ),
          ),
        );
      },
    );
  }
}
