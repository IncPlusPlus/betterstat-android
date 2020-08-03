library edit_day;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/scheduling_actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_day_screen.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'edit_day.g.dart';

class EditDay extends StatelessWidget {
  final Day day;

  EditDay({this.day, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, day),
      builder: (BuildContext context, _ViewModel vm) => AddEditDayScreen(
        key: vm.screenKey,
        isEditing: vm.isEditing,
        onSave: vm.onSave,
        day: vm.dayToEdit,
      ),
    );
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  Key get screenKey;

  bool get isEditing;

  Function(String name, List<SetPointTimeTuple> times) get onSave;

  Day get dayToEdit;

  static _ViewModel fromStore(Store<AppState> store, Day dayToEdit) {
    return _ViewModel((b) => b
      ..screenKey = BetterstatKeys.editDayScreen
      ..isEditing = true
      ..onSave = (String name, List<SetPointTimeTuple> times) {
        store.dispatch(UpdateDayAction(
            updatedDay: Day.builder((b) {
              return b
                ..name = name
                ..times = BuiltList<SetPointTimeTuple>.from(times).toBuilder();
            }),
            originalDay: dayToEdit));
      }
      ..dayToEdit = dayToEdit.toBuilder());
  }
}
