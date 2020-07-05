import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/generated/l10n.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

typedef OnTabsSelected = void Function(int);

class TabSelector extends StoreConnector<AppState, AppActions, AppTab> {
  TabSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AppTab activeTab, AppActions action) {
    return BottomNavigationBar(
      key: BetterstatKeys.tabs,
      currentIndex: AppTab.toIndex(activeTab),
      onTap: (index) {
        action.updateTabAction(AppTab.fromIndex(index));
      },
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.schedules ? Icons.list : Icons.show_chart,
            key: tab == AppTab.stats
                ? BetterstatKeys.statsTab
                : BetterstatKeys.scheduleTab,
          ),
          title: Text(tab == AppTab.stats
              ? S.of(context).stats
              : S.of(context).schedules),
        );
      }).toList(),
    );
  }

  @override
  AppTab connect(AppState state) => state.activeTab;
}
