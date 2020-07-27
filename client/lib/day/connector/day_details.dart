library day_details;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/day/presentation/day_details_screen.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Builder;

part 'day_details.g.dart';

class DayDetails extends StatelessWidget {
  final Day day;

  DayDetails({Key key, @required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromKnownInfo(store, day),
        builder: (BuildContext context, _ViewModel vm) => DayDetailsScreen(
              day: vm.day,
              onDelete: vm.onDelete,
            ));
  }
}

abstract class _ViewModel implements Built<_ViewModel, _ViewModelBuilder> {
  factory _ViewModel([Function(_ViewModelBuilder b) updates]) = _$ViewModel;

  _ViewModel._();

  Day get day;

  Function get onDelete;

  static _ViewModel fromKnownInfo(Store<AppState> store, Day day) {
    return _ViewModel((b) => b
      ..day = day.toBuilder()
      ..onDelete = () => store.dispatch(DeleteDayAction(dayId: day.id)));
  }
}
