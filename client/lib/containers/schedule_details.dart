library schedule_details;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/presentation/schedule_details_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Builder;

part 'schedule_details.g.dart';

class ScheduleDetails extends StatelessWidget {
  final Schedule schedule;

  ScheduleDetails({Key key, @required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromKnownInfo(store, schedule),
        builder: (BuildContext context, _ViewModel vm) => ScheduleDetailsScreen(
              schedule: vm.schedule,
              onDelete: vm.onDelete,
            ));
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  Schedule get schedule;

  VoidCallback get onDelete;

  static _ViewModel fromKnownInfo(Store<AppState> store, Schedule schedule) {
    return _ViewModel((b) => b
      ..schedule = schedule.toBuilder()
      ..onDelete = () {
        store.dispatch(DeleteScheduleAction(scheduleId: schedule.id));
      });
  }
}
