import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/add_edit_day_screen.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class EditDay extends StoreConnector<AppState, AppActions, Null> {
  final Day day;

  EditDay({this.day, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, _, AppActions actions) {
    return AddEditDayScreen(
      key: BetterstatKeys.editDayScreen,
      isEditing: true,
      onSave: (name, times) {
        actions.updateDayAction(UpdateDayActionPayload(
            day.id,
            day.rebuild((b) => b
              ..name = name
              ..times = BuiltList<SetPointTimeTuple>(times).toBuilder())));
      },
      day: day,
    );
  }

  @override
  Null connect(AppState state) {}
}
