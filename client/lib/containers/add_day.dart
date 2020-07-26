library add_day;

import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/presentation/add_edit_day_screen.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'add_day.g.dart';

class AddDay extends StatelessWidget {
  AddDay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (store) => ViewModel.fromStore(store),
      builder: (BuildContext context, ViewModel vm) =>
          AddEditDayScreen(isEditing: vm.isEditing, onSave: vm.onSave),
    );
  }
}

abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;

  ViewModel._();

  bool get isEditing;

  Function(String name, List<SetPointTimeTuple> times) get onSave;

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel((b) => b
      ..isEditing = false
      ..onSave = (String name, List<SetPointTimeTuple> times) {
        store.dispatch(AddDayAction(newDay: Day.builder((b) {
          return b
            ..name = name
            ..times = BuiltList<SetPointTimeTuple>.from(times).toBuilder();
        })));
      });
  }
}
