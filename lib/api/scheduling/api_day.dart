import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:betterstatmobile/api/http_api.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/serializers.dart';
import 'package:flutter/foundation.dart';

Future<Day> getDay(String id) async {
  final uri = Uri.https(apiUrl, '$dayEndpoint/$id');
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  return deserialize<Day>(jsonDecode(response.body));
}

Future<Day> putDay(Day day, String id) async {
  final uri = Uri.https(apiUrl, '$dayEndpoint/$id');
  final response = await httpClient.put(uri,
      headers: applicationJsonHeader, body: jsonEncode(serialize<Day>(day)));
  expectResponseCode(200, response);
  return deserialize<Day>(jsonDecode(response.body));
}

Future<Day> deleteDay(String id) async {
  final uri = Uri.https(apiUrl, '$dayEndpoint/$id');
  final response = await httpClient.delete(uri);
  expectResponseCode(200, response);
  return deserialize<Day>(jsonDecode(response.body));
}

Future<List<Day>> getDays() async {
  final uri = Uri.https(apiUrl, dayEndpoint);
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  // Use the compute function to run parseDays in a separate isolate.
  return compute(_parseDays, response.body);
}

Future<Day> postDay(Day day) async {
  final uri = Uri.https(apiUrl, '$dayEndpoint');
  final response = await httpClient.put(uri,
      headers: applicationJsonHeader, body: jsonEncode(serialize<Day>(day)));
  expectResponseCode(201, response);
  return deserialize<Day>(jsonDecode(response.body));
}

Future<List<Day>> _parseDays(String responseBody) async {
  final parsed = jsonDecode(responseBody) as List;
  return deserializeListOf<Day>(parsed).toList();
}
