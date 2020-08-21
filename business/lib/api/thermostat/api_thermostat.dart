import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:betterstatmobile_business_logic/api/http_api.dart';
import 'package:betterstatmobile_business_logic/models/serializers.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:flutter/foundation.dart';

Future<Thermostat> getThermostat(String id) async {
  final uri = Uri.https(apiUrl, '$thermostatEndpoint/$id');
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  return deserialize<Thermostat>(jsonDecode(response.body));
}

Future<Thermostat> putThermostat(Thermostat thermostat, String id) async {
  final uri = Uri.https(apiUrl, '$thermostatEndpoint/$id');
  final response = await httpClient.put(uri,
      headers: applicationJsonHeader,
      body: jsonEncode(serialize<Thermostat>(thermostat)));
  expectResponseCode(200, response);
  return deserialize<Thermostat>(jsonDecode(response.body));
}

Future<Thermostat> deleteThermostat(String id) async {
  final uri = Uri.https(apiUrl, '$thermostatEndpoint/$id');
  final response = await httpClient.delete(uri);
  expectResponseCode(200, response);
  return deserialize<Thermostat>(jsonDecode(response.body));
}

Future<List<Thermostat>> getThermostats() async {
  final uri = Uri.https(apiUrl, thermostatEndpoint);
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  // Use the compute function to run parseThermostats in a separate isolate.
  return compute(_parseThermostats, response.body);
}

Future<Thermostat> postThermostat(Thermostat thermostat) async {
  final uri = Uri.https(apiUrl, '$thermostatEndpoint');
  final response = await httpClient.post(uri,
      headers: applicationJsonHeader,
      body: jsonEncode(serialize<Thermostat>(thermostat)));
  //TODO: Should be 201 but server returns 200
  expectResponseCode(200, response);
  return deserialize<Thermostat>(jsonDecode(response.body));
}

Future<List<Thermostat>> _parseThermostats(String responseBody) async {
  final parsed = jsonDecode(responseBody) as List;
  return deserializeListOf<Thermostat>(parsed).toList();
}
