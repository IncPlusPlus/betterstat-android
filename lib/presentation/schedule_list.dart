// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:betterstatmobile/containers/app_loading.dart';
import 'package:betterstatmobile/containers/schedule_details.dart';
import 'package:betterstatmobile/localization.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/schedule_item.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final Function(Schedule) onRemove;
  final Function(Schedule) onUndoRemove;

  ScheduleList({
    @required this.schedules,
    @required this.onRemove,
    @required this.onUndoRemove,
  }) : super(key: BetterstatKeys.todoList);

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return loading
          ? Center(
              key: BetterstatKeys.todosLoading,
              child: CircularProgressIndicator(
                key: BetterstatKeys.statsLoading,
              ))
          : Container(
              child: ListView.builder(
                key: BetterstatKeys.todoList,
                itemCount: schedules.length,
                itemBuilder: (BuildContext context, int index) {
                  final schedule = schedules[index];

                  return ScheduleItem(
                    schedule: schedule,
                    onTap: () => _onScheduleTap(context, schedule),
                  );
                },
              ),
            );
    });
  }

  void _removeTodo(BuildContext context, Schedule schedule) {
    onRemove(schedule);

    Scaffold.of(context).showSnackBar(SnackBar(
        key: BetterstatKeys.snackbar,
        duration: Duration(seconds: 2),
        content: Text(
          BetterstatLocalizations.of(context).scheduleDeleted(schedule.name),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: BetterstatLocalizations.of(context).undo,
          onPressed: () => onUndoRemove(schedule),
        )));
  }

  void _onScheduleTap(BuildContext context, Schedule schedule) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ScheduleDetails(
            id: schedule.id,
          );
        },
      ),
    ).then((removedTodo) {
      if (removedTodo != null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            key: BetterstatKeys.snackbar,
            duration: Duration(seconds: 2),
            content: Text(
              BetterstatLocalizations.of(context).scheduleDeleted(schedule.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: BetterstatLocalizations.of(context).undo,
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
