import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:betterstatmobile_business_logic/api/http_api.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/models/serializers.dart';

Stream<ThermostatSetupStatus> setupStream(String thermostatId) {
  return Stream.periodic(Duration(seconds: 1))
      .asyncMap((event) => getStatus(thermostatId));
}

Future initSetup(String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/init');
  final response = await httpClient.put(uri);
  expectResponseCode(200, response);
}

Future<DescriptivePortNameSystemPortNamePair> getPorts(
    String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/ports');
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  return deserialize<DescriptivePortNameSystemPortNamePair>(
      jsonDecode(response.body));
}

Future portConnect(String thermostatId, String port) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/portConnect');
  final response = await httpClient.put(uri, body: port);
  expectResponseCode(200, response);
}

Future wifiSsid(String thermostatId, String wifiSsid) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/wifiSsid');
  final response = await httpClient.put(uri, body: wifiSsid);
  expectResponseCode(200, response);
}

Future wifiPassword(String thermostatId, String wifiPassword) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/wifiPassword');
  final response = await httpClient.put(uri, body: wifiPassword);
  expectResponseCode(200, response);
}

Future serverHostname(String thermostatId, String serverHostname,
    bool hostnameIsAnIP, bool isSecure, int port) async {
  var queryParameters = {
    'hostnameIsAnIP': hostnameIsAnIP,
    'isSecure': isSecure,
    'port': port,
  };
  final uri = Uri.https(
    apiUrl,
    '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/serverHostname',
    queryParameters,
  );
  final response = await httpClient.put(uri, body: serverHostname);
  expectResponseCode(200, response);
}

Future beginSetup(String thermostatId) async {
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

Future completeSetup(String thermostatId) async {
  final uri = Uri.https(apiUrl,
      '$thermostatEndpoint/$thermostatId/$thermostatSetupEndpointSuffix/complete');
  final response = await httpClient.put(uri);
  expectResponseCode(200, response);
}
