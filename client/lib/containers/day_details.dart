import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/presentation/day_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class DayDetails extends StoreConnector<AppState, AppActions, Day> {
  final String id;

  DayDetails({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, Day day, AppActions actions) {
    return DayDetailsScreen(
      day: day,
      onDelete: () => actions.deleteDayAction(day.id),
    );
  }

  @override
  Day connect(AppState state) {
    return state.days.firstWhere(
      (day) => day.id == id,
      orElse: () => Day(),
    );
  }
}
