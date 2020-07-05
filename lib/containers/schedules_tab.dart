import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/schedule_list.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:betterstatmobile/util/routes.dart';
import 'package:betterstatmobile/util/specialized_completer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class SchedulesTab
    extends StoreConnector<AppState, AppActions, List<Schedule>> {
  SchedulesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, List<Schedule> state, AppActions actions) {
    return Scaffold(
      body: ScheduleList(
        schedules: state,
        onRefresh: (SpecializedCompleterTuple tuple) {
          actions.fetchSchedulesAction(tuple);
          return tuple.completer.future;
        },
        onRemove: (schedule) {
          actions.deleteScheduleAction(schedule.id);
        },
        onUndoRemove: (schedule) {
          actions.addScheduleAction(schedule);
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: BetterstatKeys.addScheduleFab,
        onPressed: () {
          Navigator.pushNamed(context, BetterstatRoutes.addSchedule);
        },
        child: Icon(Icons.add),
        tooltip: S.of(context).addSchedule,
      ),
    );
  }

  @override
  List<Schedule> connect(AppState state) => state.schedulesSelector;
}
