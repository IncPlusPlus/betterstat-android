library stats_tab;

import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/stats_counter.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

part 'stats_tab.g.dart';

class Stats extends StoreConnector<AppState, AppActions, StatsProps> {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, StatsProps props, AppActions actions) {
    return StatsCounter(
      numActive: props.numActive,
      numCompleted: props.numCompleted,
    );
  }

  @override
  StatsProps connect(AppState state) {
    return StatsProps((b) => b
      ..numCompleted = state.numCompletedSelector
      ..numActive = state.numActiveSelector);
  }
}

abstract class StatsProps implements Built<StatsProps, StatsPropsBuilder> {
  factory StatsProps([Function(StatsPropsBuilder b) updates]) = _$StatsProps;

  StatsProps._();

  int get numActive;

  int get numCompleted;
}
