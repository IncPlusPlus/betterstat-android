import 'dart:core';
import 'package:betterstatmobile/models/models.dart';

abstract class SchedulesRepository {
  Future<Schedule> createSchedule(Schedule schedule);

  Future<List<Schedule>> loadSchedules();

  Future<Schedule> loadSchedule(String id);

  Future saveSchedule(Schedule schedule, String id);

  Future deleteSchedule(String id);
}
