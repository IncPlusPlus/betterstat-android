import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:betterstatmobile/api/exceptions.dart';
import 'package:betterstatmobile/http_api.dart';
import 'package:betterstatmobile/models/app_state.dart';
import 'package:betterstatmobile/models/schedule.dart';
import 'package:betterstatmobile/models/serializers.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart';
import 'package:time_machine/time_machine.dart';

Future<Schedule> postSchedule(Schedule schedule) async {
  final uri = Uri.http(apiUrl, '$scheduleEndpoint');
  final response = await httpClient.put(uri,
      headers: applicationJsonHeader,
      body: jsonEncode(serialize<Schedule>(schedule))).timeout(timeout);
  _expectResponseCode(201, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<List<Schedule>> getSchedules() async {
  final uri = Uri.http(apiUrl, scheduleEndpoint);
  final response = await httpClient.get(uri).timeout(timeout);
  _expectResponseCode(200, response);
  // Use the compute function to run parseSchedules in a separate isolate.
  return compute(_parseSchedules, response.body);
}

Future<Schedule> getSchedule(String id) async {
  final uri = Uri.http(apiUrl, '$scheduleEndpoint/$id');
  final response = await httpClient.get(uri).timeout(timeout);
  _expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<Schedule> putSchedule(Schedule schedule, String id) async {
  final uri = Uri.http(apiUrl, '$scheduleEndpoint/$id');
  final response = await httpClient.put(uri,
      headers: applicationJsonHeader,
      body: jsonEncode(serialize<Schedule>(schedule))).timeout(timeout);
  _expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<Schedule> deleteSchedule(Schedule schedule, String id) async {
  final uri = Uri.http(apiUrl, '$scheduleEndpoint/$id');
  final response = await httpClient.delete(uri).timeout(timeout);
  _expectResponseCode(200, response);
  return deserialize<Schedule>(jsonDecode(response.body));
}

Future<List<Schedule>> _parseSchedules(String responseBody) async {
  final parsed = jsonDecode(responseBody) as List;
  return deserializeListOf<Schedule>(parsed).toList();
}

void _expectResponseCode(int expectedCode, Response response) {
  if(expectedCode != response.statusCode) {
    throw UnexpectedResponseException(expectedCode, response.statusCode, responseBody: jsonDecode(response.body));
  }
}
