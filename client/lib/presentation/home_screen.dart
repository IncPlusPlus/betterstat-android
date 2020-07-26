import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_client_components/containers/days_tab.dart';
import 'package:betterstatmobile_client_components/containers/schedules_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            ],
          ),
        ),
//          body: activeTab == AppTab.schedules ? SchedulesTab() : Stats(),
        body: TabBarView(children: [
          Icon(Icons.directions_car),
          SchedulesTab(),
          DaysTab(),
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
  }
}
