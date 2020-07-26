// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/containers/schedule_details.dart';
import 'package:betterstatmobile_client_components/presentation/schedule_item.dart';
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

//  void _removeSchedule(BuildContext context, Schedule schedule) {
//    onRemove(schedule);
//
//    Scaffold.of(context).showSnackBar(SnackBar(
//        key: BetterstatKeys.snackbar,
//        duration: Duration(seconds: 2),
//        content: Text(
//          S.of(context).scheduleDeleted(schedule.name),
//          maxLines: 1,
//          overflow: TextOverflow.ellipsis,
//        ),
//        action: SnackBarAction(
//          label: S.of(context).undo,
//          onPressed: () => onUndoRemove(schedule),
//        )));
//  }

  Future<void> _showMyDialog(BuildContext context, Object error,
      [StackTrace stackTrace]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('An error occurred'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(error.toString()),
                Text(stackTrace.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
