//library stats_tab;
//
//import 'package:betterstatmobile_business_logic/actions/actions.dart';
//import 'package:betterstatmobile_business_logic/models/models.dart';
//import 'package:betterstatmobile_client_components/presentation/stats_counter.dart';
//import 'package:built_value/built_value.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:async_redux/async_redux.dart';
//
//part 'stats_tab.g.dart';
//
//class Stats extends StatelessWidget {
//  Stats({Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreConnector<AppState, ViewModel>(
//      converter: (store) => ViewModel.fromStore(store),
//      builder: (BuildContext context, ViewModel vm) => StatsCounter(
//        numActive: vm.numActive,
//        numCompleted: vm.numCompleted,
//      ),
//    );
//  }
//}
//
//abstract class ViewModel implements Built<ViewModel, ViewModelBuilder> {
//  factory ViewModel([Function(ViewModelBuilder b) updates]) = _$ViewModel;
//
//  ViewModel._();
//
//  static ViewModel fromStore(Store<AppState> store) {
//    return ViewModel((b) => b
//      ..numCompleted = store.state.numCompletedSelector
//      ..numActive = store.state.numActiveSelector);
//  }
//
//  int get numActive;
//
//  int get numCompleted;
//}
