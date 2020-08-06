import 'dart:async';

import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/day/connector/day_details.dart';
import 'package:betterstatmobile_client_components/day/presentation/day_item.dart';
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
      /*
       * When the navigator pops, it will contain the Day the user was just viewing
       * if they hit the delete button. This behavior is defined with DayDetailsScreen.onDelete
       */
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
}
