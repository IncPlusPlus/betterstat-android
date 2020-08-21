import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/repository/generic_future_repository.dart';
import 'package:betterstatmobile_business_logic/repository/thermostat_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

GenericFutureRepository<Thermostat, String> _thermostatRepository =
    const ThermostatRepository();

class AddThermostatAction extends ReduxAction<AppState> {
  final Thermostat newThermostat;

  AddThermostatAction({@required this.newThermostat})
      : assert(newThermostat != null);

  @override
  Future<AppState> reduce() async {
    var createdThermostat =
        await _thermostatRepository.createById(newThermostat);
    return state.rebuild((b) async => b
      ..thermostats = state.thermostats
          .rebuild((b) => b.add(createdThermostat))
          .toBuilder());
  }
}

class DeleteThermostatAction extends ReduxAction<AppState> {
  final String thermostatId;

  DeleteThermostatAction({@required this.thermostatId})
      : assert(thermostatId != null);

  @override
  Future<AppState> reduce() async {
    var deletedThermostat =
        await _thermostatRepository.deleteById(thermostatId);
    return state.rebuild((b) => b
      ..thermostats = state.thermostats
          .rebuild((b) => b.remove(deletedThermostat))
          .toBuilder());
  }
}

class FetchThermostatsAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    var newList = await _thermostatRepository.getAll();
    return state.rebuild((b) =>
        b..thermostats = BuiltList<Thermostat>.from(newList).toBuilder());
  }
}

class UpdateThermostatAction extends ReduxAction<AppState> {
  final Thermostat originalThermostat;
  final Thermostat updatedThermostat;

  UpdateThermostatAction(
      {@required this.updatedThermostat, @required this.originalThermostat})
      : assert(updatedThermostat != null),
        assert(originalThermostat != null);

  @override
  Future<AppState> reduce() async {
    var savedUpdatedThermostat = await _thermostatRepository.saveById(
        updatedThermostat, originalThermostat.id);
    return state.rebuild((b) => b
      ..thermostats = state.thermostats
          .rebuild((b) => b
            ..remove(originalThermostat)
            ..add(savedUpdatedThermostat))
          .toBuilder());
  }
}
