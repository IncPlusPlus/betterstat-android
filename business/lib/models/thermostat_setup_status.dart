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

  @nullable
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

  static BuiltSet<ThermostatSetupStep> get steps =>
      BuiltSet<ThermostatSetupStep>(const <ThermostatSetupStep>[
        _$NEED_THERMOSTAT_CONNECTION,
        _$WAITING_FOR_DEVICE_RESPONSE,
        _$SETUP_READY_TO_PROCEED,
        _$PROVIDING_DEVICE_WITH_WIFI_CREDENTIALS,
        _$DEVICE_CONNECTING_TO_WIFI,
        _$PROVIDING_DEVICE_WITH_API_CREDENTIALS,
        _$PROVIDING_DEVICE_WITH_HOSTNAME_INFO,
        _$DEVICE_CONNECTING_TO_SERVER,
        _$DONE,
      ]);

  String get description =>
      _descriptions[this] ??
      (throw StateError('No description value for ThermostatSetupStep.$name'));

  static const _descriptions = {
    ERROR: 'An error has occurred.',
    NEED_THERMOSTAT_CONNECTION:
        'Thermostat needs to be plugged into the server',
    WAITING_FOR_DEVICE_RESPONSE: 'Waiting to hear back from the thermostat',
    SETUP_READY_TO_PROCEED:
        'Waiting on user to start setup process. Ready to proceed.',
    PROVIDING_DEVICE_WITH_WIFI_CREDENTIALS:
        'Providing device with WiFi credentials',
    DEVICE_CONNECTING_TO_WIFI: 'Device connecting to WiFi...',
    PROVIDING_DEVICE_WITH_API_CREDENTIALS:
        'Providing thermostat with API credentials',
    PROVIDING_DEVICE_WITH_HOSTNAME_INFO:
        'Providing thermostat with hostname information',
    DEVICE_CONNECTING_TO_SERVER:
        'Thermostat is attempting to connect to the server',
    DONE: 'Done!',
  };

  int get step =>
      _steps[this] ??
      (throw StateError('No step value for ThermostatSetupStep.$name'));

  static const _steps = {
    NEED_THERMOSTAT_CONNECTION: 1,
    WAITING_FOR_DEVICE_RESPONSE: 2,
    SETUP_READY_TO_PROCEED: 3,
    PROVIDING_DEVICE_WITH_WIFI_CREDENTIALS: 4,
    DEVICE_CONNECTING_TO_WIFI: 5,
    PROVIDING_DEVICE_WITH_API_CREDENTIALS: 6,
    PROVIDING_DEVICE_WITH_HOSTNAME_INFO: 7,
    DEVICE_CONNECTING_TO_SERVER: 8,
    DONE: 9,
  };
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
