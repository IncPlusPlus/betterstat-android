library scheudle;

import 'dart:convert';

import 'package:betterstatmobile/models/models.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:meta/meta.dart';
import 'package:time_machine/time_machine.dart';
import 'package:time_machine/time_machine_text_patterns.dart';
import 'package:built_collection/built_collection.dart';

part 'schedule.g.dart';

abstract class Schedule implements Built<Schedule, ScheduleBuilder> {
  static Serializer<Schedule> get serializer => _$scheduleSerializer;

  String get id;

  String get name;

  BuiltList<SetPointTimeTuple> get times;

  Schedule._();

  factory Schedule([void Function(ScheduleBuilder) updates]) = _$Schedule;

  factory Schedule.builder([void Function(ScheduleBuilder b) updates]) {
    final builder = ScheduleBuilder()
      ..id = ''
      ..name = ''
      ..times = BuiltList<SetPointTimeTuple>([]).toBuilder()
      ..update(updates);

    return builder.build();
  }
}

abstract class SetPointTimeTuple
    implements Built<SetPointTimeTuple, SetPointTimeTupleBuilder> {
  @BuiltValueSerializer(custom: true)
  static Serializer<SetPointTimeTuple> get serializer =>
      SetPointTimeTupleSerializer();

  double get setPoint;

  LocalTime get time;

  SetPointTimeTuple._();

  factory SetPointTimeTuple([void Function(SetPointTimeTupleBuilder) updates]) =
      _$SetPointTimeTuple;

  factory SetPointTimeTuple.builder([void Function(SetPointTimeTupleBuilder) updates]) {
    final builder = SetPointTimeTupleBuilder()
        ..setPoint = 0.0
        ..time = null
        ..update(updates);

    return builder.build();
  }
}

class SetPointTimeTupleSerializer
    implements StructuredSerializer<SetPointTimeTuple> {
  @override
  SetPointTimeTuple deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    // Initialize an empty builder
    final result = SetPointTimeTupleBuilder();

    // Create an `Iterator` from the serialized data received
    final iterator = serialized.iterator;
    // Loop the iterator for each key
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      // for each key, assign the correct value to the builder
      switch (key) {
        case 'setPoint':
          result.setPoint = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'time':
          result.time =
              LocalTimePattern.extendedIso.parse(value).getValueOrThrow();
          break;
      }
    }
    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, SetPointTimeTuple object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'setPoint',
      serializers.serialize(object.setPoint,
          specifiedType: const FullType(double)),
      'time',
LocalTimePattern.extendedIso.format(object.time),
    ];

    return result;
  }

  @override
  Iterable<Type> get types => [SetPointTimeTuple, _$SetPointTimeTuple];

  @override
  String get wireName => 'SetPointTimeTuple';
}
