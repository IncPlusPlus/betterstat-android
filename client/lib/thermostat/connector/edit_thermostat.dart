library edit_thermostat;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_thermostat_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'edit_thermostat.g.dart';

class EditThermostat extends StatelessWidget {
  final Thermostat thermostat;

  EditThermostat({this.thermostat, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, thermostat),
      builder: (BuildContext context, _ViewModel vm) => AddEditThermostatScreen(
        key: vm.screenKey,
        isEditing: vm.isEditing,
        onSave: vm.onSave,
        thermostat: vm.thermostatToEdit,
      ),
    );
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  Key get screenKey;

  bool get isEditing;

  Function(String name, bool heatingSupported, bool airConditioningSupported,
      bool fanSupported) get onSave;

  Thermostat get thermostatToEdit;

  static _ViewModel fromStore(
      Store<AppState> store, Thermostat thermostatToEdit) {
    return _ViewModel((b) => b
      ..screenKey = BetterstatKeys.editThermostatScreen
      ..isEditing = true
      ..onSave = (String name, bool heatingSupported,
          bool airConditioningSupported, bool fanSupported) {
        store.dispatch(UpdateThermostatAction(
            updatedThermostat: Thermostat.builder((b) {
              return b
                ..name = name
                ..heatingSupported = heatingSupported
                ..airConditioningSupported = airConditioningSupported
                ..fanSupported = fanSupported;
            }),
            originalThermostat: thermostatToEdit));
      }
      ..thermostatToEdit = thermostatToEdit.toBuilder());
  }
}
