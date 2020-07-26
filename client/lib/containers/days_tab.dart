library days_tab;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/presentation/day_list.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'days_tab.g.dart';

/*
 * TODO: All of the *Tab classes are "connectors". Move and rename them accordingly. Also, the Widget components of this should be refactored out (such as the Scaffold).
 */
class DaysTab extends StatelessWidget {
  DaysTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatchFuture(FetchDaysAction()),
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) => DayList(
        days: vm.days,
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

  List<Day> get days;

  Function(Day) get onRemove;

  Function(Day) get onUndoRemove;

  Future<void> Function() get onRefresh;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel((b) => b
      ..days = store.state.daysSelector
      ..onRefresh = () {
        return store.dispatchFuture(FetchDaysAction());
      }
      ..onRemove = (day) {
        store.dispatch(DeleteDayAction(dayId: day.id));
      }
      ..onUndoRemove = (day) {
        store.dispatch(AddDayAction(newDay: day));
      });
  }
}
