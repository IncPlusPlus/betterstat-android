import 'package:betterstatmobile/containers/edit_day.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/settings.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _padding = EdgeInsets.all(16.0);

class DayDetailsScreen extends StatelessWidget {
  final Day day;
  final Function onDelete;

  DayDetailsScreen({
    Key key,
    @required this.day,
    @required this.onDelete,
  }) : super(key: BetterstatKeys.dayDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.dayDetails),
        actions: [
          IconButton(
            tooltip: localizations.deleteDay,
            icon: Icon(Icons.delete),
            key: BetterstatKeys.deleteDayButton,
            onPressed: () {
              onDelete();
              Navigator.pop(context, day);
            },
          )
        ],
      ),
      body: _buildPanel(context),
      floatingActionButton: FloatingActionButton(
        key: BetterstatKeys.editDayFab,
        tooltip: localizations.editDay,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditDay(
                  day: day,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget setPointDisplay(
      SetPointTimeTuple setPointTimeTuple, BuildContext context) {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // This is the widget that accepts text input. In this case, it
          // accepts numbers and calls the onChanged property on update.
          // You can read more about it here: https://flutter.io/text-input
          Center(
              child: Text(
            getPrefTemp(setPointTimeTuple.setPoint).toString() +
                ' °${getPreferredTempUnit().toString().substring(getPreferredTempUnit().toString().indexOf('.') + 1)}',
            style: Theme.of(context).textTheme.headline5,
          )),
        ],
      ),
    );
  }

  Widget timeDisplay(
      SetPointTimeTuple setPointTimeTuple, BuildContext context) {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            child: Center(
              child: Text(
                setPointTimeTuple.time.toString('hh:mm tt'),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel(BuildContext context) {
    return ListView.builder(
      itemCount: day.times.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: _padding,
                    child: timeDisplay(day.times[index], context))),
            Expanded(
                child: Padding(
                    padding: _padding,
                    child: setPointDisplay(day.times[index], context)))
          ],
        );
      },
    );
  }
}
