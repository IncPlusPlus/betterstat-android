import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_business_logic/util/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Day day;

  DayItem({
    @required this.onTap,
    @required this.day,
  }) : super(key: BetterstatKeys.dayItem(day.id));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: Icon(Icons.view_day),
          title: Text(
            day.name,
            key: BetterstatKeys.dayItemName(day.id),
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            'id: ${day.id}',
            key: BetterstatKeys.dayItem(day.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
