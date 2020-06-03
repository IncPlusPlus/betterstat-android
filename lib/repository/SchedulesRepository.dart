import 'dart:core';

import 'package:betterstatmobile/models/models.dart';

abstract class SchedulesRepository {
  Future<Schedule> createSchedule(Schedule schedule);

  Future deleteSchedule(String id);

  Future<Schedule> loadSchedule(String id);

  Future<List<Schedule>> loadSchedules();

  Future saveSchedule(Schedule schedule, String id);
}
