import 'package:betterstatmobile/containers/edit_schedule.dart';
import 'package:betterstatmobile/generated/l10n.dart';
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
      body: _buildPanel(context),
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

//  Widget setPointDisplay(
//      SetPointTimeTuple setPointTimeTuple, BuildContext context) {
//    return Padding(
//      padding: _padding,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: [
//          // This is the widget that accepts text input. In this case, it
//          // accepts numbers and calls the onChanged property on update.
//          // You can read more about it here: https://flutter.io/text-input
//          Center(
//              child: Text(
//            getPrefTemp(setPointTimeTuple.setPoint).toString() +
//                ' °${getPreferredTempUnit().toString().substring(getPreferredTempUnit().toString().indexOf('.') + 1)}',
//            style: Theme.of(context).textTheme.headline5,
//          )),
//        ],
//      ),
//    );
//  }
//
//  Widget timeDisplay(
//      SetPointTimeTuple setPointTimeTuple, BuildContext context) {
//    return Padding(
//      padding: _padding,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: [
//          InkWell(
//            child: Center(
//              child: Text(
//                setPointTimeTuple.time.toString('hh:mm tt'),
//                style: Theme.of(context).textTheme.headline5,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }

  Widget _buildPanel(BuildContext context) {
    return ListView();
  }
}
