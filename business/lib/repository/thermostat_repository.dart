import 'dart:core';

import 'package:betterstatmobile_business_logic/api/thermostat/api_thermostat.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/repository/generic_future_repository.dart';

class ThermostatRepository
    implements GenericFutureRepository<Thermostat, String> {
  const ThermostatRepository();

  @override
  Future<Thermostat> createById(Thermostat thermostat) {
    return postThermostat(thermostat);
  }

  @override
  Future<Thermostat> deleteById(String id) {
    return deleteThermostat(id);
  }

  @override
  Future<Thermostat> getById(String id) {
    return getThermostat(id);
  }

  @override
  Future<List<Thermostat>> getAll() {
    return getThermostats();
  }

  @override
  Future<Thermostat> saveById(Thermostat thermostat, String id) {
    return putThermostat(thermostat, id);
  }
}
