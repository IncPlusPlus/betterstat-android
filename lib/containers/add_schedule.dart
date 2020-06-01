import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:built_collection/built_collection.dart';

class AddSchedule extends StoreConnector<AppState, AppActions, Null> {
  AddSchedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, Null ignored, AppActions actions) {
    return AddEditScreen(
        isEditing: false,
        onSave: (String name, List<SetPointTimeTuple> times) {
          actions.addScheduleAction(Schedule.builder((b) {
            return b
              ..name = name
              ..times = BuiltList<SetPointTimeTuple>(times).toBuilder();
          }));
        });
  }

  @override
  Null connect(AppState state) {}
}
