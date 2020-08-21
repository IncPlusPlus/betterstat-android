import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const _formTextStyle = TextStyle(fontSize: 20.0);

class ConfigureThermostatScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final Future<void> Function(
      String wifiSsid,
      String wifiPassword,
      String serverHostname,
      bool hostnameIsAnIP,
      bool isSecure,
      int port) onSave;

  ConfigureThermostatScreen({Key key, @required this.onSave})
      : assert(onSave != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure thermostat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _fbKey,
          child: ListView(
            children: <Widget>[
              FormBuilderTextField(
                attribute: 'ssid',
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'WiFi SSID',
                ),
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderTextField(
                attribute: 'password',
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'WiFi password',
                ),
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderTextField(
                attribute: 'serverHostname',
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Server hostname',
                ),
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderTextField(
                attribute: 'port',
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Server port',
                ),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ],
              ),
              FormBuilderCheckbox(
                attribute: 'hostnameIsAnIP',
                initialValue: false,
                label: Text(
                  'Hostname is an IP address',
                  style: _formTextStyle,
                ),
              ),
              FormBuilderCheckbox(
                attribute: 'isSecure',
                initialValue: false,
                label: Text(
                  'Use HTTPS to connect',
                  style: _formTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Begin setup',
        child: Icon(Icons.check),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            var formValue = _fbKey.currentState.value;
            onSave(
                    formValue['ssid'],
                    formValue['password'],
                    formValue['serverHostname'],
                    formValue['hostnameIsAnIP'],
                    formValue['isSecure'],
                    int.tryParse(formValue['port']))
                .then((value) => Navigator.pop(context));
            /*
             * TODO: See if we could navigate forward from here such that the setup progress page is pushed onto the navigator. If and only if the setup finishes successfully, should this page be popped. Currently, you need to navigate back here yourself.
             *  (THIS MAY NOT BE RELEVANT ANYMORE AFTER USING FUTURE.THEN)
             */

          }
        },
      ),
    );
  }
}
