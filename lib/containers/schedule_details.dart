import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/schedule_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class ScheduleDetails extends StoreConnector<AppState, AppActions, Schedule> {
  final String id;

  ScheduleDetails({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, Schedule schedule, AppActions actions) {
    return DetailsScreen(
      schedule: schedule,
      onDelete: () => actions.deleteScheduleAction(schedule.id),
//      toggleCompleted: (isComplete) {
//        actions.updateScheduleAction(UpdateScheduleActionPayload(
//          id,
//          schedule.rebuild((b) => b..complete = isComplete),
//        ));
//      },
    );
  }

  @override
  Schedule connect(AppState state) {
    return state.schedules.firstWhere(
      (schedule) => schedule.id == id,
      orElse: () => Schedule(),
    );
  }
}
