// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_business_logic/util/routes.dart';
import 'package:betterstatmobile_client_components/thermostat/connector/thermostat_details.dart';
import 'package:betterstatmobile_client_components/thermostat/presentation/thermostat_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

class ThermostatList extends StatelessWidget {
  final List<Thermostat> thermostats;
  final Function(Thermostat) onRemove;
  final Function(Thermostat) onUndoRemove;
  final Future<void> Function() onRefresh;

  ThermostatList({
    @required this.thermostats,
    @required this.onRemove,
    @required this.onUndoRemove,
    @required this.onRefresh,
  }) : super(key: BetterstatKeys.thermostatList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: onRefresh,
          child: ListView.builder(
            key: BetterstatKeys.thermostatList,
            itemCount: thermostats.length,
            itemBuilder: (BuildContext context, int index) {
              final thermostat = thermostats[index];

              return ThermostatItem(
                thermostat: thermostat,
                onTap: () => {_onThermostatTap(context, thermostat)},
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: BetterstatKeys.addThermostatFab,
          onPressed: () {
            Navigator.pushNamed(context, BetterstatRoutes.addThermostat);
          },
          child: Icon(Icons.add),
          tooltip: S.of(context).addSchedule,
        ));
  }

  void _onThermostatTap(BuildContext context, Thermostat thermostat) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ThermostatDetails(
            thermostat: thermostat,
          );
        },
      ),
    ).then((removedThermostat) {
      if (removedThermostat != null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            key: BetterstatKeys.snackbar,
            duration: Duration(seconds: 2),
            content: Text(
              S.of(context).itemDeleted(thermostat.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: S.of(context).undo,
              onPressed: () {
                onUndoRemove(thermostat);
              },
            ),
          ),
        );
      }
    });
  }

//  void _removeThermostat(BuildContext context, Thermostat thermostat) {
//    onRemove(thermostat);
//
//    Scaffold.of(context).showSnackBar(SnackBar(
//        key: BetterstatKeys.snackbar,
//        duration: Duration(seconds: 2),
//        content: Text(
//          S.of(context).thermostatDeleted(thermostat.name),
//          maxLines: 1,
//          overflow: TextOverflow.ellipsis,
//        ),
//        action: SnackBarAction(
//          label: S.of(context).undo,
//          onPressed: () => onUndoRemove(thermostat),
//        )));
//  }

  Future<void> _showMyDialog(BuildContext context, Object error,
      [StackTrace stackTrace]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('An error occurred'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(error.toString()),
                Text(stackTrace.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
