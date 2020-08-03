library thermostats_tab;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/thermostat_actions.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_client_components/thermostat/presentation/thermostat_list.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'thermostats_tab.g.dart';

/*
 * TODO: All of the *Tab classes are "connectors". Move and rename them accordingly.
 *  Also, the Widget components of this should be refactored out (such as the Scaffold).
 */
class ThermostatsTab extends StatelessWidget {
  ThermostatsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      onInit: (store) => store.dispatchFuture(FetchThermostatsAction()),
      builder: (BuildContext context, _ViewModel vm) => ThermostatList(
        thermostats: vm.thermostats,
        onRefresh: vm.onRefresh,
        onRemove: vm.onRemove,
        onUndoRemove: vm.onUndoRemove,
      ),
    );
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  List<Thermostat> get thermostats;

  Function(Thermostat) get onRemove;

  Function(Thermostat) get onUndoRemove;

  Future<void> Function() get onRefresh;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel((b) => b
      ..thermostats = store.state.thermostatsSelector
      ..onRefresh = () {
        return store.dispatchFuture(FetchThermostatsAction());
      }
      ..onRemove = (thermostat) {
        store.dispatch(DeleteThermostatAction(thermostatId: thermostat.id));
      }
      ..onUndoRemove = (thermostat) {
        store.dispatch(AddThermostatAction(newThermostat: thermostat));
      });
  }
}
