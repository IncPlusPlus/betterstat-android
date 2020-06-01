library stats_tab;

import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/stats_counter.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

part 'stats_tab.g.dart';

abstract class StatsProps implements Built<StatsProps, StatsPropsBuilder> {
  int get numCompleted;

  int get numActive;

  StatsProps._();

  factory StatsProps([Function(StatsPropsBuilder b) updates]) = _$StatsProps;
}

class Stats extends StoreConnector<AppState, AppActions, StatsProps> {
  Stats({Key key}) : super(key: key);

  @override
  StatsProps connect(AppState state) {
    return StatsProps((b) => b
      ..numCompleted = state.numCompletedSelector
      ..numActive = state.numActiveSelector);
  }

  @override
  Widget build(BuildContext context, StatsProps props, AppActions actions) {
    return StatsCounter(
      numActive: props.numActive,
      numCompleted: props.numCompleted,
    );
  }
}
