import 'package:auto_size_text/auto_size_text.dart';
import 'package:betterstatmobile/containers/edit_schedule.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _padding = EdgeInsets.all(16.0);

class ScheduleDetailsScreen extends StatelessWidget {
  final Schedule schedule;
  final Function onDelete;

  ScheduleDetailsScreen({
    Key key,
    @required this.schedule,
    @required this.onDelete,
  }) : super(key: BetterstatKeys.scheduleDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.scheduleDetails),
        actions: [
          IconButton(
            tooltip: localizations.deleteSchedule,
            icon: Icon(Icons.delete),
            key: BetterstatKeys.deleteScheduleButton,
            onPressed: () {
              onDelete();
              Navigator.pop(context, schedule);
            },
          )
        ],
      ),
      body: _buildPanel(),
      floatingActionButton: FloatingActionButton(
        key: BetterstatKeys.editScheduleFab,
        tooltip: localizations.editSchedule,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditSchedule(
                  schedule: schedule,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget dayDisplay(int dayOfWeek) {
    Day day;
    String dayOfWeekName;
    //Choose which of the local Day variables (denoted with an underscore) to assign to the Day we're constructing a Widget with
    switch (dayOfWeek) {
      case 0:
        day = schedule.sunday;
        dayOfWeekName = 'Sunday';
        break;
      case 1:
        day = schedule.monday;
        dayOfWeekName = 'Monday';
        break;
      case 2:
        day = schedule.tuesday;
        dayOfWeekName = 'Tuesday';
        break;
      case 3:
        day = schedule.wednesday;
        dayOfWeekName = 'Wednesday';
        break;
      case 4:
        day = schedule.thursday;
        dayOfWeekName = 'Thursday';
        break;
      case 5:
        day = schedule.friday;
        dayOfWeekName = 'Friday';
        break;
      case 6:
        day = schedule.saturday;
        dayOfWeekName = 'Saturday';
        break;
    }
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            dayOfWeekName,
            style: TextStyle(fontSize: 20),
            maxLines: 1,
            overflowReplacement: Text('Sorry String too long'),
          ),
        ),
        Spacer(),
        Expanded(
          child: AutoSizeText(
            day.name,
            style: TextStyle(fontSize: 30),
            maxLines: 2,
            overflowReplacement: Text('Name too long'),
          ),
        ),
      ],
    );
    //return a Widget involving the particular Day we chose
  }

  Widget _buildPanel() {
    return Padding(
      padding: _padding,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Padding(padding: _padding, child: dayDisplay(index)))
            ],
          );
        },
      ),
    );
  }
}
