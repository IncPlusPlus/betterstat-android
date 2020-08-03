library add_schedule;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/scheduling_actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_schedule_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'add_schedule.g.dart';

class AddSchedule extends StatelessWidget {
  AddSchedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromStore(store),
      builder: (BuildContext context, ViewModel vm) =>
          AddEditScheduleScreen(isEditing: vm.isEditing, onSave: vm.onSave),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  bool get isEditing;

  Function(String name, Day sunday, Day monday, Day tuesday, Day wednesday,
      Day thursday, Day friday, Day saturday) get onSave;

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel((b) => b
      ..isEditing = false
      ..onSave = (String name, Day sunday, Day monday, Day tuesday,
          Day wednesday, Day thursday, Day friday, Day saturday) {
        store.dispatch(AddScheduleAction(newSchedule: Schedule.builder((b) {
          return b
            ..name = name
            ..sunday = sunday.toBuilder()
            ..monday = monday.toBuilder()
            ..tuesday = tuesday.toBuilder()
            ..wednesday = wednesday.toBuilder()
            ..thursday = thursday.toBuilder()
            ..friday = friday.toBuilder()
            ..saturday = saturday.toBuilder();
        })));
      });
  }
}
