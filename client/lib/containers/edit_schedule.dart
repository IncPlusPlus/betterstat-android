import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_schedule_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class EditSchedule extends StoreConnector<AppState, AppActions, Null> {
  final Schedule schedule;

  EditSchedule({this.schedule, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, _, AppActions actions) {
    return AddEditScheduleScreen(
      key: BetterstatKeys.editScheduleScreen,
      isEditing: true,
      onSave: (String name, Day sunday, Day monday, Day tuesday, Day wednesday,
          Day thursday, Day friday, Day saturday) {
        actions.updateScheduleAction(UpdateScheduleActionPayload(
            schedule.id,
            schedule.rebuild((b) => b
              ..name = name
              ..sunday = sunday.toBuilder()
              ..monday = monday.toBuilder()
              ..tuesday = tuesday.toBuilder()
              ..wednesday = wednesday.toBuilder()
              ..thursday = thursday.toBuilder()
              ..friday = friday.toBuilder()
              ..saturday = saturday.toBuilder())));
      },
      schedule: schedule,
    );
  }

  @override
  Null connect(AppState state) {}
}
