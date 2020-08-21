library day;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:time_machine/time_machine.dart';
import 'package:time_machine/time_machine_text_patterns.dart';

part 'day.g.dart';

abstract class Day implements Built<Day, DayBuilder> {
  static Serializer<Day> get serializer => _$daySerializer;

  factory Day([void Function(DayBuilder) updates]) = _$Day;

  factory Day.builder([void Function(DayBuilder b) updates]) {
    final builder = DayBuilder()
      ..id = ''
      ..name = ''
      ..times = BuiltList<SetPointTimeTuple>([]).toBuilder()
      ..update(updates);

    return builder.build();
  }

  Day._();

  String get id;

  String get name;

  BuiltList<SetPointTimeTuple> get times;
}

abstract class SetPointTimeTuple
    implements Built<SetPointTimeTuple, SetPointTimeTupleBuilder> {
  @BuiltValueSerializer(custom: true)
  static Serializer<SetPointTimeTuple> get serializer =>
      SetPointTimeTupleSerializer();

  factory SetPointTimeTuple([void Function(SetPointTimeTupleBuilder) updates]) =
      _$SetPointTimeTuple;

  factory SetPointTimeTuple.builder(
      [void Function(SetPointTimeTupleBuilder) updates]) {
    final builder = SetPointTimeTupleBuilder()
      ..setPoint = 0.0
      ..time = LocalTime.currentClockTime()
      ..update(updates);

    return builder.build();
  }

  SetPointTimeTuple._();

  double get setPoint;

  LocalTime get time;
}

class SetPointTimeTupleSerializer
    implements StructuredSerializer<SetPointTimeTuple> {
  @override
  Iterable<Type> get types => [SetPointTimeTuple, _$SetPointTimeTuple];

  @override
  String get wireName => 'SetPointTimeTuple';

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
}
