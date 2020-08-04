import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/models/thermostat_setup_status.dart';
import 'package:flutter/material.dart';

class ThermostatSetupScreen extends StatelessWidget {
  final ThermostatSetupStatus status;

  final Future<void> Function() onDone;

  final Future<void> Function() completeSetup;

  const ThermostatSetupScreen(
      {Key key,
      @required this.status,
      @required this.onDone,
      @required this.completeSetup})
      : assert(onDone != null),
        assert(completeSetup != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup status'),
      ),
      body: Center(
        child: _buildWhenStatusNotNull(context),
      ),
    );
  }

  Widget _buildWhenStatusNotNull(BuildContext context) {
    if (status == null) {
      return Column(
        children: [
          Text(
            'Waiting to hear back from the server...',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          CircularProgressIndicator(
            value: null,
          ),
        ],
      );
    } else {
      var percentage = status.currentStep == null
          ? Container()
          : Text(
              'Step ${status.currentStep.step} of ${ThermostatSetupStep.steps.length}',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            );
      var percentageSpacer =
          status.currentStep == null ? Container() : const SizedBox(height: 10);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status.currentStep.description,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          _buildIfTextNotEmpty(Text(
            status.ongoingProcess,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )),
          _buildIfTextNotEmpty(Text(
            status.exception,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )),
          const SizedBox(height: 30),
          percentage,
          percentageSpacer,
          CircularProgressIndicator(
            value: status.currentStep == null
                ? null
                : (1.0 * status.currentStep.step) /
                    ThermostatSetupStep.steps.length,
          ),
          const SizedBox(height: 30),
          _conditionallyAddDoneButton(context),
        ],
      );
    }
  }

  ///Returns a [text] widget if the contained data is not empty.
  ///Otherwise, this returns an empty [Container].
  ///This is useful for spacing purposes. If there's no text, widgets look like they're
  ///far apart from each other for no good reason.
  Widget _buildIfTextNotEmpty(Text text) {
    return text.data.isEmpty ? Container() : text;
  }

  Widget _conditionallyAddDoneButton(BuildContext context) {
    if (status.currentStep == ThermostatSetupStep.DONE) {
      return RaisedButton(
        onPressed: () {
          onDone()
              .then((value) => completeSetup())
              .then((value) => Navigator.pop(context));
        },
        child: Text('Continue', style: TextStyle(fontSize: 20)),
      );
    } else {
      return Container();
    }
  }
}
