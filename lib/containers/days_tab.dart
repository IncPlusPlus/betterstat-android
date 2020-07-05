import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/presentation/day_list.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:betterstatmobile/util/routes.dart';
import 'package:betterstatmobile/util/specialized_completer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class DaysTab extends StoreConnector<AppState, AppActions, List<Day>> {
  DaysTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, List<Day> state, AppActions actions) {
    return Scaffold(
        body: DayList(
          days: state,
          onRefresh: (SpecializedCompleterTuple tuple) {
            actions.fetchDaysAction(tuple);
            return tuple.completer.future;
          },
          onRemove: (day) {
            actions.deleteDayAction(day.id);
          },
          onUndoRemove: (day) {
            actions.addDayAction(day);
          },
        ),
        floatingActionButton: FloatingActionButton(
          key: BetterstatKeys.addDayFab,
          onPressed: () {
            Navigator.pushNamed(context, BetterstatRoutes.addDay);
          },
          child: Icon(Icons.add),
          tooltip: S.of(context).addSchedule,
        ));
  }

  @override
  List<Day> connect(AppState state) => state.daysSelector;
}
