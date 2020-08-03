import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ThermostatItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Thermostat thermostat;

  ThermostatItem({
    @required this.onTap,
    @required this.thermostat,
  }) : super(key: BetterstatKeys.thermostatItem(thermostat.id));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: Icon(MaterialCommunityIcons.thermostat),
          title: Text(
            thermostat.name,
            key: BetterstatKeys.thermostatItemName(thermostat.id),
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            'id: ${thermostat.id}',
            key: BetterstatKeys.thermostatItem(thermostat.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
