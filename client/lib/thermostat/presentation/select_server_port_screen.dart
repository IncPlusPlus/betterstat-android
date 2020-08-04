import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:flutter/material.dart';

class SelectServerPortScreen extends StatelessWidget {
  final List<DescriptivePortNameSystemPortNamePair> ports;
  final Future<void> Function(DescriptivePortNameSystemPortNamePair port)
      onPortSelect;

  const SelectServerPortScreen(
      {Key key, @required this.ports, @required this.onPortSelect})
      : assert(ports != null),
        assert(onPortSelect != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a port'),
      ),
      body: ports.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: CircularProgressIndicator(
                  value: null,
                ),
              ),
            )
          : ListView.builder(
              itemCount: ports.length,
              itemBuilder: (BuildContext context, int index) {
                final port = ports[index];
                return Card(
                  child: ListTile(
                    title: Text(port.descriptivePortName),
                    subtitle: Text(port.systemPortName),
                    onTap: () => onPortSelect(port)
                        .then((value) => Navigator.pop(context)),
                  ),
                );
              },
            ),
    );
  }
}
