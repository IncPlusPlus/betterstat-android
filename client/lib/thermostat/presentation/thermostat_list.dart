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
}
