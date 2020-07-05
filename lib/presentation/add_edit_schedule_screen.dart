import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/keys.dart';
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
            TextFormField(
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
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_name, _sunday, _monday, _tuesday, _wednesday,
                _thursday, _friday, _saturday);

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
    _sunday = widget.schedule.sunday;
    _monday = widget.schedule.monday;
    _tuesday = widget.schedule.tuesday;
    _wednesday = widget.schedule.wednesday;
    _thursday = widget.schedule.thursday;
    _friday = widget.schedule.friday;
    _saturday = widget.schedule.saturday;
  }

  Widget dayDisplay(int dayOfWeek) {
    Day day;
    //Choose which of the local Day variables (denoted with an underscore) to assign to the Day we're constructing a Widget with
    switch (dayOfWeek) {
      case 0:
        day = _sunday;
        break;
      case 1:
        day = _monday;
        break;
      case 2:
        day = _tuesday;
        break;
      case 3:
        day = _wednesday;
        break;
      case 4:
        day = _thursday;
        break;
      case 5:
        day = _friday;
        break;
      case 6:
        day = _saturday;
        break;
    }
    return Text('sample text');
    //return a Widget involving the particular Day we chose
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
}
