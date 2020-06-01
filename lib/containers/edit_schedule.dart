import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/add_edit_screen.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:built_collection/built_collection.dart';

class EditSchedule extends StoreConnector<AppState, AppActions, Null> {
  final Schedule schedule;

  EditSchedule({this.schedule, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, _, AppActions actions) {
    return AddEditScreen(
      key: BetterstatKeys.editScheduleScreen,
      isEditing: true,
      onSave: (name, times) {
        actions.updateScheduleAction(UpdateScheduleActionPayload(
            schedule.id,
            schedule.rebuild((b) => b
              ..name = name
              ..times = BuiltList<SetPointTimeTuple>(times).toBuilder())));
      },
      schedule: schedule,
    );
  }

  @override
  Null connect(AppState state) {}
}