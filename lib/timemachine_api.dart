import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:time_machine/time_machine.dart';

Future<void> initTimeMachine() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Sets up timezone and culture information
  await TimeMachine.initialize({'rootBundle': rootBundle});
}