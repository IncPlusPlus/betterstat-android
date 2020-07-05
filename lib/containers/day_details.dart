import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/day_details_screen.dart';
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
