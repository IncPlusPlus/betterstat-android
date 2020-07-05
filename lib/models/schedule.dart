library scheudle;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'day.dart';

part 'schedule.g.dart';

abstract class Schedule implements Built<Schedule, ScheduleBuilder> {
  static Serializer<Schedule> get serializer => _$scheduleSerializer;

  factory Schedule([void Function(ScheduleBuilder) updates]) = _$Schedule;

  factory Schedule.builder([void Function(ScheduleBuilder b) updates]) {
    final builder = ScheduleBuilder()
      ..id = ''
      ..name = ''
      ..sunday = null
      ..monday = null
      ..tuesday = null
      ..wednesday = null
      ..thursday = null
      ..friday = null
      ..saturday = null
      ..update(updates);

    return builder.build();
  }

  Schedule._();

  String get id;

  String get name;

  Day get sunday;

  Day get monday;

  Day get tuesday;

  Day get wednesday;

  Day get thursday;

  Day get friday;

  Day get saturday;
}
