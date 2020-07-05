import 'dart:core';

import 'package:betterstatmobile/api/scheduling/api_schedule.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/repository/generic_future_repository.dart';

class ScheduleRepository implements GenericFutureRepository<Schedule, String> {
  const ScheduleRepository();

  @override
  Future<Schedule> createById(Schedule schedule) {
    return postSchedule(schedule);
  }

  @override
  Future<Schedule> deleteById(String id) {
    return deleteSchedule(id);
  }

  @override
  Future<Schedule> getById(String id) {
    return getSchedule(id);
  }

  @override
  Future<List<Schedule>> getAll() {
    return getSchedules();
  }

  @override
  Future saveById(Schedule schedule, String id) {
    return putSchedule(schedule, id);
  }
}
