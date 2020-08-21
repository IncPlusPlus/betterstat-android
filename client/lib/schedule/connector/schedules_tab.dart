library schedules_tab;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/scheduling_actions.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/models/schedule.dart';
import 'package:betterstatmobile_client_components/schedule/presentation/schedule_list.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'schedules_tab.g.dart';

/*
 * TODO: All of the *Tab classes are "connectors". Move and rename them accordingly.
 *  Also, the Widget components of this should be refactored out (such as the Scaffold).
 */
class SchedulesTab extends StatelessWidget {
  SchedulesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      onInit: (store) => store.dispatchFuture(FetchSchedulesAction()),
      builder: (BuildContext context, _ViewModel vm) => ScheduleList(
        schedules: vm.schedules,
        onRefresh: vm.onRefresh,
        onRemove: vm.onRemove,
        onUndoRemove: vm.onUndoRemove,
      ),
    );
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  List<Schedule> get schedules;

  Function(Schedule) get onRemove;

  Function(Schedule) get onUndoRemove;

  Future<void> Function() get onRefresh;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel((b) => b
      ..schedules = store.state.schedulesSelector
      ..onRefresh = () {
        return store.dispatchFuture(FetchSchedulesAction());
      }
      ..onRemove = (schedule) {
        store.dispatch(DeleteScheduleAction(scheduleId: schedule.id));
      }
      ..onUndoRemove = (schedule) {
        store.dispatch(AddScheduleAction(newSchedule: schedule));
      });
  }
}
