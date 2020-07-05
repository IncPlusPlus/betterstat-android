library thermostat;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'thermostat.g.dart';

abstract class Thermostat implements Built<Thermostat, ThermostatBuilder> {
  static Serializer<Thermostat> get serializer => _$thermostatSerializer;

  factory Thermostat([void Function(ThermostatBuilder) updates]) = _$Thermostat;

  factory Thermostat.builder([void Function(ThermostatBuilder b) updates]) {
    final builder = ThermostatBuilder()
      ..id = ''
      ..setUp = false
      ..name = ''
      ..heatingSupported = false
      ..airConditioningSupported = false
      ..fanSupported = false
      ..fanSetting = FanSetting.AUTO
      ..state = States.IDLE
      ..update(updates);

    return builder.build();
  }

  Thermostat._();

  String get id;

  bool get setUp;

  String get name;

  bool get heatingSupported;

  bool get airConditioningSupported;

  bool get fanSupported;

  FanSetting get fanSetting;

  States get state;
}

class FanSetting extends EnumClass {
  static const FanSetting ON = _$ON;
  static const FanSetting AUTO = _$AUTO;

  static Serializer<FanSetting> get serializer => _$fanSettingSerializer;

  const FanSetting._(String name) : super(name);

  static BuiltSet<FanSetting> get values => _$fanSettingValues;

  static FanSetting valueOf(String name) => _$fanSettingValueOf(name);
}

class States extends EnumClass {
  static const States IDLE = _$IDLE;
  static const States COOLING = _$COOLING;
  static const States HEATING = _$HEATING;

  static Serializer<States> get serializer => _$statesSerializer;

  const States._(String name) : super(name);

  static BuiltSet<States> get values => _$statesValues;

  static States valueOf(String name) => _$statesValueOf(name);
}
