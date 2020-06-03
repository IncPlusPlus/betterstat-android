import 'dart:core';
import 'package:http/http.dart' as http;


final http.Client httpClient = http.Client();
final Duration timeout = Duration(seconds: 30);

/// The API endpoint we want to hit.
final String apiUrl = '10.0.2.2:8080';
final String scheduleEndpoint = '/schedule';
final Map<String, String> applicationJsonHeader = {'Content-Type':'application/json'};
