import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:betterstatmobile_business_logic/api/http_api.dart';
import 'package:betterstatmobile_business_logic/models/schedule.dart';
import 'package:betterstatmobile_business_logic/models/serializers.dart';
import 'package:flutter/foundation.dart';

Future<Schedule> getSchedule(String id) async {
  final uri = Uri.https(apiUrl, '$scheduleEndpoint/$id');
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<Schedule> putSchedule(Schedule schedule, String id) async {
  final uri = Uri.https(apiUrl, '$scheduleEndpoint/$id');
  final response = await httpClient.put(uri,
      headers: applicationJsonHeader,
      body: jsonEncode(serialize<Schedule>(schedule)));
  expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<Schedule> deleteSchedule(String id) async {
  final uri = Uri.https(apiUrl, '$scheduleEndpoint/$id');
  final response = await httpClient.delete(uri);
  expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<List<Schedule>> getSchedules() async {
  final uri = Uri.https(apiUrl, scheduleEndpoint);
  final response = await httpClient.get(uri);
  expectResponseCode(200, response);
  // Use the compute function to run parseSchedules in a separate isolate.
  return compute(_parseSchedules, response.body);
}

Future<Schedule> postSchedule(Schedule schedule) async {
  final uri = Uri.https(apiUrl, '$scheduleEndpoint');
  final response = await httpClient.post(uri,
      headers: applicationJsonHeader,
      body: jsonEncode(serialize<Schedule>(schedule)));
  //TODO: Should be 201
  expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<void> setDayOfWeek(
    String scheduleId, DayOfWeek dayOfWeek, String dayId) async {
  final uri =
      Uri.https(apiUrl, '$scheduleEndpoint/$scheduleId/set${dayOfWeek.name}');
  final response =
      await httpClient.put(uri, headers: applicationJsonHeader, body: dayId);
  expectResponseCode(200, response);
}

Future<List<Schedule>> _parseSchedules(String responseBody) async {
  final parsed = jsonDecode(responseBody) as List;
  return deserializeListOf<Schedule>(parsed).toList();
}
