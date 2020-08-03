import 'package:auto_size_text/auto_size_text.dart';
import 'package:betterstatmobile_business_logic/generated/l10n.dart';
import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_client_components/thermostat/connector/edit_thermostat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _padding = EdgeInsets.all(16.0);

class ThermostatDetailsScreen extends StatelessWidget {
  final Thermostat thermostat;
  final Function onDelete;

  ThermostatDetailsScreen({
    Key key,
    @required this.thermostat,
    @required this.onDelete,
  }) : super(key: BetterstatKeys.thermostatDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.thermostatDetails),
        actions: [
          IconButton(
            tooltip: localizations.deleteThermostat,
            icon: Icon(Icons.delete),
            key: BetterstatKeys.deleteThermostatButton,
            onPressed: () {
              onDelete();
              Navigator.pop(context, thermostat);
            },
          )
        ],
      ),
      body: Padding(
        padding: _padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              thermostat.name,
              style: TextStyle(
                fontSize: 50,
              ),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
//            Expanded(child: buildThermostatDetailsScreen(context, thermostat))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: BetterstatKeys.editThermostatFab,
        tooltip: localizations.editThermostat,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditThermostat(
                  thermostat: thermostat,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//Widget buildThermostatDetailsScreen(BuildContext context, Thermostat thermostat) {
//  return ListView.builder(
//    itemCount: thermostat.times.length,
//    itemBuilder: (context, index) {
//      return Card(
//        elevation: 2,
//        child: ,
//      );
//    },
//  );
//}
