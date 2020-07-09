import 'package:auto_size_text/auto_size_text.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/forms/form_extras.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _padding = EdgeInsets.all(16.0);

typedef OnSaveCallback = void Function(String task, String note);

class AddEditScheduleScreen extends StatefulWidget {
  final bool isEditing;
  final Function(String name, Day sunday, Day monday, Day tuesday,
      Day wednesday, Day thursday, Day friday, Day saturday) onSave;
  final Schedule schedule;

  AddEditScheduleScreen(
      {Key key, @required this.onSave, @required this.isEditing, this.schedule})
      : super(key: key ?? BetterstatKeys.addScheduleScreen);

  @override
  _AddEditScheduleScreenState createState() => _AddEditScheduleScreenState();
}

class _AddEditScheduleScreenState extends State<AddEditScheduleScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;

//  List<SetPointTimeTuple> _times;
  Day _sunday;
  Day _monday;
  Day _tuesday;
  Day _wednesday;
  Day _thursday;
  Day _friday;
  Day _saturday;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editSchedule : localizations.addSchedule,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: _padding,
              child: TextFormField(
                initialValue: isEditing ? widget.schedule.name : '',
                key: BetterstatKeys.nameField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: localizations.newScheduleHint,
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? localizations.emptyTextFieldError
                      : null;
                },
                onSaved: (value) => _name = value,
              ),
            ),
            Expanded(child: _buildPanel())
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing
            ? BetterstatKeys.saveScheduleFab
            : BetterstatKeys.saveNewSchedule,
        tooltip:
        isEditing ? localizations.saveChanges : localizations.addSchedule,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          //TODO: Make the form invalid if any days aren't selected
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(
                _name,
                _sunday,
                _monday,
                _tuesday,
                _wednesday,
                _thursday,
                _friday,
                _saturday);

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //We want copies of the original instances which we will then replace upon
    // submitting the form.
    if (isEditing) {
      _sunday = widget.schedule.sunday;
      _monday = widget.schedule.monday;
      _tuesday = widget.schedule.tuesday;
      _wednesday = widget.schedule.wednesday;
      _thursday = widget.schedule.thursday;
      _friday = widget.schedule.friday;
      _saturday = widget.schedule.saturday;
    }
  }

  Widget dayDisplay(int dayOfWeek) {
    Day day;
    String dayOfWeekName;
    //Choose which of the local Day variables (denoted with an underscore) to assign to the Day we're constructing a Widget with
    switch (dayOfWeek) {
      case 0:
        day = _sunday;
        dayOfWeekName = 'Sunday';
        break;
      case 1:
        day = _monday;
        dayOfWeekName = 'Monday';
        break;
      case 2:
        day = _tuesday;
        dayOfWeekName = 'Tuesday';
        break;
      case 3:
        day = _wednesday;
        dayOfWeekName = 'Wednesday';
        break;
      case 4:
        day = _thursday;
        dayOfWeekName = 'Thursday';
        break;
      case 5:
        day = _friday;
        dayOfWeekName = 'Friday';
        break;
      case 6:
        day = _saturday;
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
          ),
        ),
        Spacer(),
        Expanded(child: currentlySetDayDisplay(day, dayOfWeek)),
      ],
    );
    //return a Widget involving the particular Day we chose
  }

  Widget currentlySetDayDisplay(Day day, int dayOfWeekIndex) {
    return DaySelectionFormField(
      initialValue: day,
      onSaved: (Day newValue) => updateSelectedDay(newValue, dayOfWeekIndex),
    );
  }

  Widget _buildPanel() {
    return ListView.builder(
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
    );
  }

  void updateSelectedDay(Day newValue, int dayOfWeekIndex) {
    setState(() {
      switch (dayOfWeekIndex) {
        case 0:
          _sunday = newValue;
          break;
        case 1:
          _monday = newValue;
          break;
        case 2:
          _tuesday = newValue;
          break;
        case 3:
          _wednesday = newValue;
          break;
        case 4:
          _thursday = newValue;
          break;
        case 5:
          _friday = newValue;
          break;
        case 6:
          _saturday = newValue;
          break;
      }
    });
  }
}
