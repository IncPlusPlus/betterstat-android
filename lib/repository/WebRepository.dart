import 'dart:core';

import 'package:betterstatmobile/api/schedule/api_schedule.dart';
import 'package:betterstatmobile/models/schedule.dart';
import 'package:betterstatmobile/repository/SchedulesRepository.dart';

class WebRepository implements SchedulesRepository {
  const WebRepository();

  @override
  Future<List<Schedule>> loadSchedules() {
    return getSchedules();
  }

  @override
  Future saveSchedule(Schedule schedule, String id) {
    return putSchedule(schedule,id);
  }

  @override
  Future deleteSchedule(String id) {
    return deleteSchedule(id);
  }

  @override
  Future<Schedule> createSchedule(Schedule schedule) {
    return postSchedule(schedule);
  }

  @override
  Future<Schedule> loadSchedule(String id) {
    return getSchedule(id);
  }
}