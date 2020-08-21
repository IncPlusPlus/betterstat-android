library schedule;

import 'package:built_collection/built_collection.dart';
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

  @nullable
  Day get sunday;

  @nullable
  Day get monday;

  @nullable
  Day get tuesday;

  @nullable
  Day get wednesday;

  @nullable
  Day get thursday;

  @nullable
  Day get friday;

  @nullable
  Day get saturday;
}

class DayOfWeek extends EnumClass {
  static const DayOfWeek Sunday = _$Sunday;
  static const DayOfWeek Monday = _$Monday;
  static const DayOfWeek Tuesday = _$Tuesday;
  static const DayOfWeek Wednesday = _$Wednesday;
  static const DayOfWeek Thursday = _$Thursday;
  static const DayOfWeek Friday = _$Friday;
  static const DayOfWeek Saturday = _$Saturday;

  static Serializer<DayOfWeek> get serializer => _$dayOfWeekSerializer;

  const DayOfWeek._(String name) : super(name);

  static BuiltSet<DayOfWeek> get values => _$dayOfWeekValues;

  static DayOfWeek valueOf(String name) => _$dayOfWeekValueOf(name);
}
