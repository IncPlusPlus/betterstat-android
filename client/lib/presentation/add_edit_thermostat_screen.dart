import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const _formTextStyle = TextStyle(fontSize: 20.0);

typedef OnSaveCallback = void Function(String task, String note);

class AddEditThermostatScreen extends StatefulWidget {
  final bool isEditing;
  final Function(String name, bool heatingSupported,
      bool airConditioningSupported, bool fanSupported) onSave;
  final Thermostat thermostat;

  AddEditThermostatScreen(
      {Key key,
      @required this.onSave,
      @required this.isEditing,
      this.thermostat})
      : super(key: key ?? BetterstatKeys.addThermostatScreen);

  @override
  _AddEditThermostatScreenState createState() =>
      _AddEditThermostatScreenState();
}

class _AddEditThermostatScreenState extends State<AddEditThermostatScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? localizations.editThermostat
              : localizations.addThermostat,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            'name': isEditing ? widget.thermostat.name : '',
            'heatingSupported':
                isEditing ? widget.thermostat.heatingSupported : false,
            'airConditioningSupported':
                isEditing ? widget.thermostat.airConditioningSupported : false,
            'fanSupported': isEditing ? widget.thermostat.fanSupported : false,
          },
          child: ListView(children: <Widget>[
            FormBuilderTextField(
              attribute: 'name',
              key: BetterstatKeys.nameField,
              maxLines: 1,
              autofocus: !isEditing,
              style: textTheme.headline5,
              decoration: InputDecoration(
                hintText: localizations.newThermostatHint,
              ),
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            FormBuilderCheckbox(
              attribute: 'heatingSupported',
              label: Text(
                'Heating supported',
                style: _formTextStyle,
              ),
            ),
            FormBuilderCheckbox(
              attribute: 'airConditioningSupported',
              label: Text(
                'Air conditioning supported',
                style: _formTextStyle,
              ),
            ),
            FormBuilderCheckbox(
              attribute: 'fanSupported',
              label: Text(
                'Fan supported',
                style: _formTextStyle,
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing
            ? BetterstatKeys.saveThermostatFab
            : BetterstatKeys.saveNewThermostat,
        tooltip:
            isEditing ? localizations.saveChanges : localizations.addThermostat,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            var formValue = _fbKey.currentState.value;
            widget.onSave(
                formValue['name'],
                formValue['heatingSupported'],
                formValue['airConditioningSupported'],
                formValue['fanSupported']);

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
