library select_server_port;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_setup_actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/thermostat/presentation/select_server_port_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

import 'configure_thermostat.dart';

part 'select_server_port.g.dart';

class SelectServerPort extends StatelessWidget {
  final Thermostat thermostat;

  SelectServerPort({Key key, @required this.thermostat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromStore(store, thermostat, context),
      builder: (BuildContext context, ViewModel vm) => WillPopScope(
        onWillPop: () async {
          await vm.cancelServerPortStream();
          return true;
        },
        child: SelectServerPortScreen(
            ports: vm.ports, onPortSelect: vm.onPortSelect),
      ),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  List<DescriptivePortNameSystemPortNamePair> get ports;

  Future<void> Function() get cancelServerPortStream;

  Future<void> Function(DescriptivePortNameSystemPortNamePair port)
      get onPortSelect;

  static ViewModel fromStore(
      Store<AppState> store, Thermostat thermostat, BuildContext context) {
    store.dispatchFuture(
        StartServerPortsStreamAction(thermostatId: thermostat.id));
    return ViewModel((b) => b
      ..ports = store.state.ports.toList()
      ..cancelServerPortStream = () {
        return store.dispatchFuture(CancelServerPortsStreamAction());
      }
      ..onPortSelect = (DescriptivePortNameSystemPortNamePair port) {
        //Cancel the port listener. Then...
        return store.dispatchFuture(CancelServerPortsStreamAction()).then(
            (value) =>
                //Connect to the user-specified port. Then...
                store
                    .dispatchFuture(
                      PortConnectAction(
                        thermostatId: thermostat.id,
                        port: port,
                      ),
                    )
                    //Move to the thermostat configuration screen
                    .then((value) => Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ConfigureThermostat(
                            thermostat: thermostat,
                          );
                        }))));
      });
  }
}
