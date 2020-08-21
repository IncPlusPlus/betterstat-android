library configure_thermostat;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_setup_actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/presentation/configure_thermostat_screen.dart';
import 'package:betterstatmobile_client_components/thermostat/connector/configuration/thermostat_setup.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'configure_thermostat.g.dart';

class ConfigureThermostat extends StatelessWidget {
  final Thermostat thermostat;

  ConfigureThermostat({Key key, @required this.thermostat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromStore(store, thermostat, context),
      builder: (BuildContext context, ViewModel vm) =>
          ConfigureThermostatScreen(onSave: vm.onSave),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  Future<void> Function(
      String wifiSsid,
      String wifiPassword,
      String serverHostname,
      bool hostnameIsAnIP,
      bool isSecure,
      int port) get onSave;

  static ViewModel fromStore(
      Store<AppState> store, Thermostat thermostat, BuildContext context) {
    return ViewModel((b) => b
      ..onSave = (String wifiSsid, String wifiPassword, String serverHostname,
          bool hostnameIsAnIP, bool isSecure, int port) async {
        return store
            .dispatchFuture(SendAllDeviceInfoAction(
                ssid: wifiSsid,
                password: wifiPassword,
                serverHostname: serverHostname,
                hostnameIsAnIP: hostnameIsAnIP,
                isSecure: isSecure,
                port: port,
                thermostatId: thermostat.id))
            .then((value) => store.dispatch(
                StartThermostatSetupStreamAction(thermostatId: thermostat.id)))
            .then((value) => store.dispatchFuture(
                BeginDeviceSetupAction(thermostatId: thermostat.id)))
            .then((value) => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ThermostatSetup(
                    thermostat: thermostat,
                  );
                })));
      });
  }
}
