import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:betterstatmobile_business_logic/api/http_api.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/models/serializers.dart';
import 'package:flutter/foundation.dart';

Stream<List<DescriptivePortNameSystemPortNamePair>> createPortsStream(
    String thermostatId) {
  return Stream.periodic(Duration(seconds: 3))
      .asyncMap((event) async => await getPorts(thermostatId));
}

Stream<ThermostatSetupStatus> createSetupStream(String thermostatId) {
  return Stream.periodic(Duration(seconds: 2))
      .asyncMap((event) => getStatus(thermostatId));
}

Future initSetup(String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/init');
  final response = await httpClient.put(uri);
  expectResponseCode(200, response);
}

Future<List<DescriptivePortNameSystemPortNamePair>> getPorts(
    String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/ports');
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  // Use the compute function to run parseThermostats in a separate isolate.
  return compute(_parseThermostats, response.body);
}

Future<List<DescriptivePortNameSystemPortNamePair>> _parseThermostats(
    String responseBody) async {
  final parsed = jsonDecode(responseBody) as List;
  return deserializeListOf<DescriptivePortNameSystemPortNamePair>(parsed)
      .toList();
}

Future<void> portConnect(String thermostatId, String port) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/portConnect');
  final response = await httpClient.put(uri, body: port);
  expectResponseCode(200, response);
}

Future<void> sendWifiSsid(String thermostatId, String wifiSsid) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/wifiSsid');
  final response = await httpClient.put(uri, body: wifiSsid);
  expectResponseCode(200, response);
}

Future<void> sendWifiPassword(String thermostatId, String wifiPassword) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/wifiPassword');
  final response = await httpClient.put(uri, body: wifiPassword);
  expectResponseCode(200, response);
}

Future<void> sendServerHostname(String thermostatId, String serverHostname,
    bool hostnameIsAnIP, bool isSecure, int port) async {
  var queryParameters = {
    'hostnameIsAnIP': hostnameIsAnIP.toString(),
    'isSecure': isSecure.toString(),
    'port': port.toString(),
  };
  final uri = Uri.https(
    apiUrl,
    '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/serverHostname',
    queryParameters,
  );
  final response = await httpClient.put(uri, body: serverHostname);
  expectResponseCode(200, response);
}

Future<void> beginSetup(String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/begin');
  final response = await httpClient.put(uri);
  expectResponseCode(200, response);
}

Future<ThermostatSetupStatus> getStatus(String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/status');
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  return deserialize<ThermostatSetupStatus>(jsonDecode(response.body));
}

Future<void> completeSetup(String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/complete');
  final response = await httpClient.put(uri);
  expectResponseCode(200, response);
}
