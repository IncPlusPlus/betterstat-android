import 'dart:async';

import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/schedule/connector/schedule_details.dart';
import 'package:betterstatmobile_client_components/schedule/presentation/schedule_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final Function(Schedule) onRemove;
  final Function(Schedule) onUndoRemove;
  final Future<void> Function() onRefresh;

  ScheduleList({
    @required this.schedules,
    @required this.onRemove,
    @required this.onUndoRemove,
    @required this.onRefresh,
  }) : super(key: BetterstatKeys.scheduleList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: onRefresh,
          child: ListView.builder(
            key: BetterstatKeys.scheduleList,
            itemCount: schedules.length,
            itemBuilder: (BuildContext context, int index) {
              final schedule = schedules[index];

              return ScheduleItem(
                schedule: schedule,
                onTap: () => {_onScheduleTap(context, schedule)},
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: BetterstatKeys.addScheduleFab,
          onPressed: () {
            Navigator.pushNamed(context, BetterstatRoutes.addSchedule);
          },
          child: Icon(Icons.add),
          tooltip: S.of(context).addSchedule,
        ));
  }

  void _onScheduleTap(BuildContext context, Schedule schedule) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ScheduleDetails(
            schedule: schedule,
          );
        },
      ),
    ).then((removedSchedule) {
      if (removedSchedule != null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            key: BetterstatKeys.snackbar,
            duration: Duration(seconds: 2),
            content: Text(
              S.of(context).itemDeleted(schedule.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: S.of(context).undo,
              onPressed: () {
                onUndoRemove(schedule);
              },
            ),
          ),
        );
      }
    });
  }
}
