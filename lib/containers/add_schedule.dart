import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/add_edit_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class AddSchedule extends StoreConnector<AppState, AppActions, Null> {
  AddSchedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, Null ignored, AppActions actions) {
    return AddEditScheduleScreen(
        isEditing: false,
        onSave: (String name, Day sunday, Day monday, Day tuesday,
            Day wednesday, Day thursday, Day friday, Day saturday) {
          actions.addScheduleAction(Schedule.builder((b) {
            return b
              ..name = name
              ..sunday = sunday.toBuilder()
              ..monday = monday.toBuilder()
              ..tuesday = tuesday.toBuilder()
              ..wednesday = wednesday.toBuilder()
              ..thursday = thursday.toBuilder()
              ..friday = friday.toBuilder()
              ..saturday = saturday.toBuilder();
          }));
          actions.fetchDaysAction();

          actions.fetchDaysAction();
        });
  }

  @override
  Null connect(AppState state) {}
}
