import 'package:betterstatmobile_business_logic/models/thermostat.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_client_components/thermostat/connector/configuration/select_server_port.dart';
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
          leading: thermostat.setUp
              ? Icon(MaterialCommunityIcons.thermostat)
              : MaterialButton(
                  child: Icon(Icons.error),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Thermostat not configured'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("This thermostat hasn't been set up yet."),
                                Text('Configure it now?'),
                                const SizedBox(height: 30),
                                Text(
                                  'NOTE: Backing out of this at a later point will leave the thermostat in a not-configured state.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                //TODO: A help section in this app would clarify what would make somebody "ready" to start this process.
                                Text(
                                  "\nYou should cancel now if you don't think you're ready yet",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Configure'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return SelectServerPort(
                                    thermostat: thermostat,
                                  );
                                }));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
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
