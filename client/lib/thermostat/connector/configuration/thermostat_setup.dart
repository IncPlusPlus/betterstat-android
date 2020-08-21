library thermostat_setup;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_setup_actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/thermostat/presentation/thermostat_setup_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'thermostat_setup.g.dart';

class ThermostatSetup extends StatelessWidget {
  final Thermostat thermostat;

  ThermostatSetup({Key key, @required this.thermostat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromStore(store, thermostat),
      builder: (BuildContext context, ViewModel vm) => WillPopScope(
          onWillPop: () async {
            await vm.cancelSetupStatusStream();
            return true;
          },
          child: ThermostatSetupScreen(
              status: vm.status,
              onDone: vm.cancelSetupStatusStream,
              completeSetup: vm.completeSetup)),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  @nullable
  ThermostatSetupStatus get status;

  Future<void> Function() get cancelSetupStatusStream;

  Future<void> Function() get completeSetup;

  static ViewModel fromStore(Store<AppState> store, Thermostat thermostat) {
    return ViewModel((b) => b
      ..status = store.state.thermostatSetupMap[thermostat.id]?.toBuilder()
      ..cancelSetupStatusStream = () {
        return store.dispatchFuture(CancelThermostatSetupStreamAction());
      }
      ..completeSetup = () {
        return store.dispatchFuture(
            CompleteDeviceSetupAction(thermostatId: thermostat.id));
      });
  }
}
