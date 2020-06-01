import 'package:betterstatmobile/models/models.dart';
import 'package:betterstatmobile/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Schedule schedule;

  ScheduleItem({
    @required this.onTap,
    @required this.schedule,
  }) : super(key: BetterstatKeys.scheduleItem(schedule.id));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.schedule),
      title: Text(
        schedule.name,
        key: BetterstatKeys.scheduleItemName(schedule.id),
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        'id: ${schedule.id}',
//          key: BetterstatKeys.scheduleItem(schedule.id),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
