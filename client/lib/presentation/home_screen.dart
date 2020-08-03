import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_client_components/day/connector/days_tab.dart';
import 'package:betterstatmobile_client_components/schedule/connector/schedules_tab.dart';
import 'package:betterstatmobile_client_components/thermostat/connector/thermostats_tab.dart';
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
        body: TabBarView(children: [
          UserExceptionDialog<AppState>(child: ThermostatsTab()),
          UserExceptionDialog<AppState>(child: SchedulesTab()),
          UserExceptionDialog<AppState>(child: DaysTab()),
        ]),
      ),
    );
  }
}
