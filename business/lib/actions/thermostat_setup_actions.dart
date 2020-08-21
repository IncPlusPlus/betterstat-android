import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/api/thermostat/api_thermostat_setup.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/models/thermostat_setup_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

//<editor-fold desc="Server ports stream">
class StartServerPortsStreamAction extends ReduxAction<AppState> {
  static Stream<List<DescriptivePortNameSystemPortNamePair>> portsStream;
  static StreamSubscription<List<DescriptivePortNameSystemPortNamePair>>
      portsStreamSubscription;
  static bool _subscriptionActive = false;

  final String thermostatId;

  StartServerPortsStreamAction({@required this.thermostatId})
      : assert(thermostatId != null);

  @override
  AppState reduce() {
    //Using _subscriptionActive, this reducer will avoid creating a new stream
    //and subscription if it's not necessary. This prevents exponentially created streams.
    if (_subscriptionActive) {
      return state;
    }
    _subscriptionActive = true;
    portsStream = createPortsStream(thermostatId);
    portsStreamSubscription = portsStream.listen((event) {
      dispatchFuture(UpdateServerPortsAction(ports: event));
    });
    return state;
  }

  void cleanStreamFields() {}
}

class UpdateServerPortsAction extends ReduxAction<AppState> {
  final List<DescriptivePortNameSystemPortNamePair> ports;

  UpdateServerPortsAction({@required this.ports});

  @override
  AppState reduce() {
    return state.rebuild((b) => b
      ..ports = BuiltList<DescriptivePortNameSystemPortNamePair>.from(ports)
          .toBuilder());
  }
}

class CancelServerPortsStreamAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    StartServerPortsStreamAction.portsStreamSubscription.cancel();
    StartServerPortsStreamAction._subscriptionActive = false;
    return state;
  }
}
//</editor-fold>

//<editor-fold desc="Thermostat setup status stream">
class StartThermostatSetupStreamAction extends ReduxAction<AppState> {
  static Stream<ThermostatSetupStatus> statusStream;
  static StreamSubscription<ThermostatSetupStatus> statusStreamSubscription;
  final String thermostatId;

  StartThermostatSetupStreamAction({@required this.thermostatId})
      : assert(thermostatId != null);

  @override
  AppState reduce() {
    statusStream = createSetupStream(thermostatId);
    statusStreamSubscription =
        statusStream.listen((ThermostatSetupStatus event) {
      dispatchFuture(UpdateThermostatSetupStatusAction(
          thermostatId: thermostatId, setupStatus: event));
    });
    return state;
  }
}

class UpdateThermostatSetupStatusAction extends ReduxAction<AppState> {
  final ThermostatSetupStatus setupStatus;
  final String thermostatId;

  UpdateThermostatSetupStatusAction(
      {@required this.setupStatus, @required this.thermostatId})
      : assert(setupStatus != null);

  @override
  AppState reduce() {
    return state.rebuild((b) => b
      ..thermostatSetupMap = state.thermostatSetupMap
          .rebuild((b) => b.updateValue(thermostatId, (v) => setupStatus,
              ifAbsent: () => setupStatus))
          .toBuilder());
  }
}

class CancelThermostatSetupStreamAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    StartThermostatSetupStreamAction.statusStreamSubscription.cancel();
    return state;
  }
}
//</editor-fold>

//<editor-fold desc="Important stuff">
class InitDeviceSetupAction extends ReduxAction<AppState> {
  final String thermostatId;

  InitDeviceSetupAction({@required this.thermostatId})
      : assert(thermostatId != null);

  @override
  Future<AppState> reduce() async {
    await initSetup(thermostatId);
    return state;
  }
}

class PortConnectAction extends ReduxAction<AppState> {
  final String thermostatId;
  final DescriptivePortNameSystemPortNamePair port;

  PortConnectAction({@required this.thermostatId, @required this.port})
      : assert(thermostatId != null),
        assert(port != null);

  @override
  Future<AppState> reduce() async {
    //There really doesn't seem to be a more appropriate place to call this
    await dispatchFuture(InitDeviceSetupAction(thermostatId: thermostatId));
    await portConnect(thermostatId, port.systemPortName);
    return state;
  }
}

class SendAllDeviceInfoAction extends ReduxAction<AppState> {
  final String thermostatId;
  final String ssid;
  final String password;
  final String serverHostname;
  final bool hostnameIsAnIP;
  final bool isSecure;
  final int port;

  SendAllDeviceInfoAction(
      {@required this.thermostatId,
      @required this.ssid,
      @required this.password,
      @required this.serverHostname,
      @required this.hostnameIsAnIP,
      @required this.isSecure,
      @required this.port})
      : assert(thermostatId != null),
        assert(ssid != null),
        assert(password != null),
        assert(serverHostname != null),
        assert(hostnameIsAnIP != null),
        assert(isSecure != null),
        assert(port != null);

  @override
  Future<AppState> reduce() async {
    await dispatchFuture(
        SendWiFiSSIDAction(thermostatId: thermostatId, ssid: ssid));
    await dispatchFuture(
        SendWiFiPasswordAction(thermostatId: thermostatId, password: password));
    await dispatchFuture(SendServerHostnameAction(
        thermostatId: thermostatId,
        serverHostname: serverHostname,
        hostnameIsAnIP: hostnameIsAnIP,
        isSecure: isSecure,
        port: port));
    return state;
  }
}

class BeginDeviceSetupAction extends ReduxAction<AppState> {
  final String thermostatId;

  BeginDeviceSetupAction({@required this.thermostatId})
      : assert(thermostatId != null);

  @override
  Future<AppState> reduce() async {
    await beginSetup(thermostatId);
    return state;
  }
}

class CompleteDeviceSetupAction extends ReduxAction<AppState> {
  final String thermostatId;

  CompleteDeviceSetupAction({@required this.thermostatId})
      : assert(thermostatId != null);

  @override
  Future<AppState> reduce() async {
    await completeSetup(thermostatId);
    return state;
  }
}
//</editor-fold>

//<editor-fold desc="Actions for sending relevant info to the thermostat">
class SendWiFiSSIDAction extends ReduxAction<AppState> {
  final String thermostatId;
  final String ssid;

  SendWiFiSSIDAction({@required this.thermostatId, @required this.ssid})
      : assert(thermostatId != null),
        assert(ssid != null);

  @override
  Future<AppState> reduce() async {
    await sendWifiSsid(thermostatId, ssid);
    return state;
  }
}

class SendWiFiPasswordAction extends ReduxAction<AppState> {
  final String thermostatId;
  final String password;

  SendWiFiPasswordAction({@required this.thermostatId, @required this.password})
      : assert(thermostatId != null),
        assert(password != null);

  @override
  Future<AppState> reduce() async {
    await sendWifiPassword(thermostatId, password);
    return state;
  }
}

class SendServerHostnameAction extends ReduxAction<AppState> {
  final String thermostatId;
  final String serverHostname;
  final bool hostnameIsAnIP;
  final bool isSecure;
  final int port;

  SendServerHostnameAction(
      {@required this.thermostatId,
      @required this.serverHostname,
      @required this.hostnameIsAnIP,
      @required this.isSecure,
      @required this.port})
      : assert(thermostatId != null),
        assert(serverHostname != null),
        assert(hostnameIsAnIP != null),
        assert(isSecure != null),
        assert(port != null);

  @override
  Future<AppState> reduce() async {
    await sendServerHostname(
        thermostatId, serverHostname, hostnameIsAnIP, isSecure, port);
    return state;
  }
}
//</editor-fold>
