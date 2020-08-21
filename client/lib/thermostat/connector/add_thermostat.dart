library add_thermostat;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_thermostat_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'add_thermostat.g.dart';

class AddThermostat extends StatelessWidget {
  AddThermostat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromStore(store),
      builder: (BuildContext context, ViewModel vm) =>
          AddEditThermostatScreen(isEditing: vm.isEditing, onSave: vm.onSave),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  bool get isEditing;

  Function(String name, bool heatingSupported, bool airConditioningSupported,
      bool fanSupported) get onSave;

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel((b) => b
      ..isEditing = false
      ..onSave = (String name, bool heatingSupported,
          bool airConditioningSupported, bool fanSupported) {
        store.dispatch(
            AddThermostatAction(newThermostat: Thermostat.builder((b) {
          return b
            ..name = name
            ..heatingSupported = heatingSupported
            ..airConditioningSupported = airConditioningSupported
            ..fanSupported = fanSupported;
        })));
      });
  }
}
