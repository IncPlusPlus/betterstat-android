import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/add_edit_day_screen.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class AddDay extends StoreConnector<AppState, AppActions, Null> {
  AddDay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, Null ignored, AppActions actions) {
    return AddEditDayScreen(
        isEditing: false,
        onSave: (String name, List<SetPointTimeTuple> times) {
          actions.addDayAction(Day.builder((b) {
            return b
              ..name = name
              ..times = BuiltList<SetPointTimeTuple>(times).toBuilder();
          }));
        });
  }

  @override
  Null connect(AppState state) {}
}
