import 'package:betterstatmobile/localization.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/settings.dart';
import 'package:betterstatmobile/util/form_extras.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

const _padding = EdgeInsets.all(16.0);

typedef OnSaveCallback = void Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final Function(String name, List<SetPointTimeTuple> times) onSave;
  final Schedule schedule;

  AddEditScreen(
      {Key key, @required this.onSave, @required this.isEditing, this.schedule})
      : super(key: key ?? BetterstatKeys.addScheduleScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  List<SetPointTimeTuple> _times;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = BetterstatLocalizations.of(context);
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
                    ? localizations.emptyScheduleError
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
            widget.onSave(_name, _times);

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //We want copies of the original tuples which we will then replace upon
    // submitting the form.
    _times = List.of(widget.schedule.times);
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

  Widget timeDisplay(SetPointTimeTuple setPointTimeTuple) {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocalTimeFormField(
            initialValue: setPointTimeTuple.time,
            onSaved: (LocalTime newValue) =>
                updateTime(newValue, setPointTimeTuple),
          )
        ],
      ),
    );
  }

  void updateSetPoint(double newVal, SetPointTimeTuple setPointTimeTuple) {
    setState(() {
      _times[_times.indexOf(setPointTimeTuple)] =
          setPointTimeTuple.rebuild((b) => b..setPoint = setPrefTemp(newVal));
    });
  }

  void updateTime(LocalTime newVal, SetPointTimeTuple setPointTimeTuple) {
    setState(() {
      _times[_times.indexOf(setPointTimeTuple)] =
          setPointTimeTuple.rebuild((b) => b..time = newVal);
    });
  }

  Widget _buildPanel() {
    return ListView.builder(
      itemCount: widget.schedule.times.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Padding(
                    padding: _padding,
                    child: timeDisplay(widget.schedule.times[index]))),
            Expanded(
                child: Padding(
                    padding: _padding,
                    child: setPointDisplay(widget.schedule.times[index])))
          ],
        );
      },
    );
  }
}
