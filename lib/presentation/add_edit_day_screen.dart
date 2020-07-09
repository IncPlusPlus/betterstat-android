import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/settings.dart';
import 'package:betterstatmobile/util/forms/form_extras.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

const _padding = EdgeInsets.all(12.0);

typedef OnSaveCallback = void Function(String task, String note);

class AddEditDayScreen extends StatefulWidget {
  final bool isEditing;
  final Function(String name, List<SetPointTimeTuple> times) onSave;
  final Day day;

  AddEditDayScreen(
      {Key key, @required this.onSave, @required this.isEditing, this.day})
      : super(key: key ?? BetterstatKeys.addDayScreen);

  @override
  _AddEditDayScreenState createState() => _AddEditDayScreenState();
}

class _AddEditDayScreenState extends State<AddEditDayScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<AnimatedListState> _key =
      GlobalKey<AnimatedListState>();

  String _name;
  List<SetPointTimeTuple> _times;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editDay : localizations.addDay,
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
                initialValue: isEditing ? widget.day.name : '',
                key: BetterstatKeys.nameField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: localizations.newDayHint,
                ),
                validator: (val) {
                  return val
                      .trim()
                      .isEmpty
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
        key: isEditing ? BetterstatKeys.saveDayFab : BetterstatKeys.saveNewDay,
        tooltip: isEditing ? localizations.saveChanges : localizations.addDay,
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
    _times = List.of(widget.day.times);
  }

  Widget setPointDisplay(SetPointTimeTuple setPointTimeTuple) {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
    return AnimatedList(
      key: _key,
      initialItemCount: _times.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(_times[index], animation, index);
      },
    );
  }

  Widget _buildItem(SetPointTimeTuple tuple, Animation<double> animation,
      int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Padding(padding: _padding, child: timeDisplay(tuple))),
            Expanded(
                child:
                Padding(padding: _padding, child: setPointDisplay(tuple))),
            IconButton(
              icon: Icon(Icons.close, color: Colors.redAccent),
              onPressed: () {
                _removeItem(index);
              },
            )
          ],
        ),
      ),
    );
  }

  void _removeItem(int index) {
    var removedItem = _times.removeAt(index);
    var builder = (context, animation) {
      return _buildItem(removedItem, animation, index);
    };
    _key.currentState.removeItem(index, builder);
  }
}
