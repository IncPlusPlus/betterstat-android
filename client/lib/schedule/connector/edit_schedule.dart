library edit_schedule;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/scheduling_actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_schedule_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'edit_schedule.g.dart';

class EditSchedule extends StatelessWidget {
  final Schedule schedule;

  EditSchedule({this.schedule, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromKnownInfo(store, schedule),
      builder: (BuildContext context, ViewModel vm) => AddEditScheduleScreen(
        key: vm.screenKey,
        isEditing: vm.isEditing,
        onSave: vm.onSave,
        schedule: vm.scheduleToEdit,
      ),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  Key get screenKey;

  bool get isEditing;

  Function(String name, Day sunday, Day monday, Day tuesday, Day wednesday,
      Day thursday, Day friday, Day saturday) get onSave;

  Schedule get scheduleToEdit;

  static ViewModel fromKnownInfo(
      Store<AppState> store, Schedule scheduleToEdit) {
    return ViewModel((b) => b
      ..screenKey = BetterstatKeys.editScheduleScreen
      ..isEditing = true
      ..onSave = (String name, Day sunday, Day monday, Day tuesday,
          Day wednesday, Day thursday, Day friday, Day saturday) {
        store.dispatch(UpdateScheduleAction(
            updatedSchedule: scheduleToEdit.rebuild((b) => b
              ..name = name
              ..sunday = sunday.toBuilder()
              ..monday = monday.toBuilder()
              ..tuesday = tuesday.toBuilder()
              ..wednesday = wednesday.toBuilder()
              ..thursday = thursday.toBuilder()
              ..friday = friday.toBuilder()
              ..saturday = saturday.toBuilder()),
            originalSchedule: scheduleToEdit));
      }
      ..scheduleToEdit = scheduleToEdit.toBuilder());
  }
}
