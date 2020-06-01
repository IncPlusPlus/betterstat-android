library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppTab,
  Schedule,
  SetPointTimeTuple,
  AppState,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
)
    .build();

T deserialize<T>(dynamic value) =>
    serializers.deserializeWith<T>(serializers.serializerForType(T), value);

Object serialize<T>(T value) =>
serializers.serializeWith<T>(serializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) =>
    BuiltList.from(value.map((value) => deserialize<T>(value)).toList(growable: false));