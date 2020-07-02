import 'dart:core';

import 'package:http/http.dart' as http;

/// The API endpoint we want to hit.
final String apiUrl = '10.0.2.2:8080';
final Map<String, String> applicationJsonHeader = {
  'Content-Type': 'application/json'
};

final http.Client httpClient = http.Client();
final String scheduleEndpoint = '/schedule';
final Duration timeout = Duration(seconds: 30);
