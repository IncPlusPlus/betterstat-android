// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/containers/day_details.dart';
import 'package:betterstatmobile_client_components/presentation/day_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

class DayList extends StatelessWidget {
  final List<Day> days;
  final Function(Day) onRemove;
  final Function(Day) onUndoRemove;
  final Future<void> Function() onRefresh;

  DayList({
    @required this.days,
    @required this.onRemove,
    @required this.onUndoRemove,
    @required this.onRefresh,
  }) : super(key: BetterstatKeys.dayList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: onRefresh,
          child: ListView.builder(
            key: BetterstatKeys.dayList,
            itemCount: days.length,
            itemBuilder: (BuildContext context, int index) {
              final day = days[index];

              return DayItem(
                day: day,
                onTap: () => {_onDayTap(context, day)},
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: BetterstatKeys.addDayFab,
          onPressed: () {
            Navigator.pushNamed(context, BetterstatRoutes.addDay);
          },
          child: Icon(Icons.add),
          tooltip: S.of(context).addSchedule,
        ));
  }

  void _onDayTap(BuildContext context, Day day) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return DayDetails(
            day: day,
          );
        },
      ),
    ).then((removedDay) {
      if (removedDay != null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            key: BetterstatKeys.snackbar,
            duration: Duration(seconds: 2),
            content: Text(
              S.of(context).itemDeleted(day.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: S.of(context).undo,
              onPressed: () {
                onUndoRemove(day);
              },
            ),
          ),
        );
      }
    });
  }

//  void _removeDay(BuildContext context, Day day) {
//    onRemove(day);
//
//    Scaffold.of(context).showSnackBar(SnackBar(
//        key: BetterstatKeys.snackbar,
//        duration: Duration(seconds: 2),
//        content: Text(
//          S.of(context).dayDeleted(day.name),
//          maxLines: 1,
//          overflow: TextOverflow.ellipsis,
//        ),
//        action: SnackBarAction(
//          label: S.of(context).undo,
//          onPressed: () => onUndoRemove(day),
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
