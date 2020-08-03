library thermostat_details;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_client_components/thermostat/presentation/thermostat_details_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Builder;

part 'thermostat_details.g.dart';

class ThermostatDetails extends StatelessWidget {
  final Thermostat thermostat;

  ThermostatDetails({Key key, @required this.thermostat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromKnownInfo(store, thermostat),
        builder: (BuildContext context, _ViewModel vm) =>
            ThermostatDetailsScreen(
              thermostat: vm.thermostat,
              onDelete: vm.onDelete,
            ));
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  Thermostat get thermostat;

  Function get onDelete;

  static _ViewModel fromKnownInfo(
      Store<AppState> store, Thermostat thermostat) {
    return _ViewModel((b) => b
      ..thermostat = thermostat.toBuilder()
      ..onDelete = () =>
          store.dispatch(DeleteThermostatAction(thermostatId: thermostat.id)));
  }
}
