import 'dart:async';

import 'package:betterstatmobile/api/schedule/api_schedule.dart';
import 'package:betterstatmobile/models/schedule.dart';
import 'package:betterstatmobile/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_machine/time_machine.dart';

const _padding = EdgeInsets.all(16.0);

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

// stores ExpansionPanel state information
class Item {
  Item({
    this.setPointTimeTuple,
    this.isExpanded = false,
  });

  SetPointTimeTuple setPointTimeTuple;
  bool isExpanded;
}

List<Item> generateItems(Schedule schedule) {
  return List.generate(schedule.times.length, (int index) {
    return Item(
      setPointTimeTuple: schedule.times[index],
    );
  });
}

class ScheduleEditor extends StatefulWidget {
  Schedule schedule;

  ScheduleEditor({
    @required this.schedule,
  }) : assert(schedule != null);

  @override
  _ScheduleEditorState createState() =>
      _ScheduleEditorState(schedule: schedule);
}

class _ScheduleEditorState extends State<ScheduleEditor> {
  List<Item> _data;

  _ScheduleEditorState({
    @required Schedule schedule,
  }) : _data = generateItems(schedule);

  void updateTime(SetPointTimeTuple setPointTimeTuple) {
    Future<TimeOfDay> selectedTime = showTimePicker(
      initialTime: TimeOfDay(
          hour: setPointTimeTuple.time.hourOfDay,
          minute: setPointTimeTuple.time.minuteOfHour),
      context: context,
    );
    selectedTime.then((value) => {
          if (value != null)
            {
              setState(() {
                setPointTimeTuple.time = LocalTime(value.hour, value.minute, 0);
              })
            }
        });
  }

  void updateSetPoint(double newVal, SetPointTimeTuple setPointTimeTuple) {
    setState(() {
      setPointTimeTuple.setPoint = setPrefTemp(newVal);
    });
  }

  Future<void> _handleRefresh() async {
    widget.schedule = await getSchedule(widget.schedule.id);
    _scaffoldKey.currentState?.showSnackBar(new SnackBar(
      content: Text('Refresh complete'),
    ));
  }

  void _saveChanges() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text('Saving'),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
//    _login();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.schedule.name), actions: <Widget>[
        new IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save changes',
            onPressed: () {
              _saveChanges();
//              _refreshIndicatorKey.currentState.show();
            }),
      ]),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () => _handleRefresh(),
          child: ListView(children: [_buildPanel()])),
    );
  }

  Widget timeDisplay(SetPointTimeTuple setPointTimeTuple) {
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
            onTap: () => updateTime(setPointTimeTuple),
          ),
        ],
      ),
    );
  }

  Widget setPointDisplay(SetPointTimeTuple setPointTimeTuple) {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // This is the widget that accepts text input. In this case, it
          // accepts numbers and calls the onChanged property on update.
          // You can read more about it here: https://flutter.io/text-input
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue:
                      getPrefTemp(setPointTimeTuple.setPoint).toString(),
                  decoration: InputDecoration(
                      suffix: Text(
                    ' °${getPreferredTempUnit().toString().substring(getPreferredTempUnit().toString().indexOf('.') + 1)}',
                    style: Theme.of(context).textTheme.headline5,
                  )),
                  style: Theme.of(context).textTheme.headline5,
                  onFieldSubmitted: (value) =>
                      updateSetPoint(double.parse(value), setPointTimeTuple),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.setPointTimeTuple.time.toString('hh:mm tt')),
            );
          },
          body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: timeDisplay(item.setPointTimeTuple))),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: setPointDisplay(item.setPointTimeTuple)))
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
