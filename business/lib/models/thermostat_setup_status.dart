library thermostat_setup_status;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'thermostat_setup_status.g.dart';

abstract class ThermostatSetupStatus
    implements Built<ThermostatSetupStatus, ThermostatSetupStatusBuilder> {
  static Serializer<ThermostatSetupStatus> get serializer =>
      _$thermostatSetupStatusSerializer;
  ThermostatSetupStatus._();
  factory ThermostatSetupStatus(
          [void Function(ThermostatSetupStatusBuilder) updates]) =
      _$ThermostatSetupStatus;

  ThermostatSetupStep get currentStep;
  String get ongoingProcess;
  String get exception;
}

class ThermostatSetupStep extends EnumClass {
  static const ThermostatSetupStep ERROR = _$ERROR;
  static const ThermostatSetupStep NEED_THERMOSTAT_CONNECTION =
      _$NEED_THERMOSTAT_CONNECTION;
  static const ThermostatSetupStep WAITING_FOR_DEVICE_RESPONSE =
      _$WAITING_FOR_DEVICE_RESPONSE;
  static const ThermostatSetupStep SETUP_READY_TO_PROCEED =
      _$SETUP_READY_TO_PROCEED;
  static const ThermostatSetupStep PROVIDING_DEVICE_WITH_WIFI_CREDENTIALS =
      _$PROVIDING_DEVICE_WITH_WIFI_CREDENTIALS;
  static const ThermostatSetupStep DEVICE_CONNECTING_TO_WIFI =
      _$DEVICE_CONNECTING_TO_WIFI;
  static const ThermostatSetupStep PROVIDING_DEVICE_WITH_API_CREDENTIALS =
      _$PROVIDING_DEVICE_WITH_API_CREDENTIALS;
  static const ThermostatSetupStep PROVIDING_DEVICE_WITH_HOSTNAME_INFO =
      _$PROVIDING_DEVICE_WITH_HOSTNAME_INFO;
  static const ThermostatSetupStep DEVICE_CONNECTING_TO_SERVER =
      _$DEVICE_CONNECTING_TO_SERVER;
  static const ThermostatSetupStep DONE = _$DONE;

  static Serializer<ThermostatSetupStep> get serializer =>
      _$thermostatSetupStepSerializer;

  const ThermostatSetupStep._(String name) : super(name);

  static BuiltSet<ThermostatSetupStep> get values =>
      _$thermostatSetupStepValues;
  static ThermostatSetupStep valueOf(String name) =>
      _$thermostatSetupStepValueOf(name);
}

abstract class DescriptivePortNameSystemPortNamePair
    implements
        Built<DescriptivePortNameSystemPortNamePair,
            DescriptivePortNameSystemPortNamePairBuilder> {
  DescriptivePortNameSystemPortNamePair._();
  factory DescriptivePortNameSystemPortNamePair(
      [void Function(DescriptivePortNameSystemPortNamePairBuilder)
          updates]) = _$DescriptivePortNameSystemPortNamePair;
  static Serializer<DescriptivePortNameSystemPortNamePair> get serializer =>
      _$descriptivePortNameSystemPortNamePairSerializer;

  String get descriptivePortName;
  String get systemPortName;
}
