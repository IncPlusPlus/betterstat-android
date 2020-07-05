import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;

import 'exceptions.dart';

//TODO: Move to the `api` folder

/// The API endpoint we want to hit.
final String apiUrl = 'betterstat.incplusplus.dev';
final Map<String, String> applicationJsonHeader = {
  'Content-Type': 'application/json'
};

//TODO: Add sign-in functionality so that user credentials can be securely persisted locally
final http.Client httpClient =
    http_auth.BasicAuthClient('cloherty.ryan@gmail.com', 'mypassword');
final Duration timeout = Duration(seconds: 30);
final String scheduleEndpoint = '/schedule';
final String dayEndpoint = '/day';
final String thermostatEndpoint = '/day';

/// The URI is /thermostat/{id}[thermostatSetupEndpointSuffix]
final String thermostatSetupEndpointSuffix = '/setup';

void expectResponseCode(int expectedCode, http.Response response) {
  if (expectedCode != response.statusCode) {
    throw UnexpectedResponseException(expectedCode, response.statusCode,
        responseBody: jsonDecode(response.body));
  }
}
