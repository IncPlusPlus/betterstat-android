import 'package:flutter/material.dart';

import 'models/schedule.dart';

const _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class ScheduleTile extends StatelessWidget {
  final Schedule schedule;
  final ValueChanged<Schedule> onTap;

  const ScheduleTile({
    Key key,
    @required this.schedule,
    @required this.onTap,
  })  : assert(schedule != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: Theme.of(context).highlightColor,
          splashColor: Theme.of(context).splashColor,
          // We can use either the () => function() or the () { function(); }
          // syntax.
          onTap: () => onTap(schedule),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // There are two ways to denote a list: `[]` and `List()`.
              // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
              // You can add the type argument if you'd like, i.e. <Widget>[].
              // See https://www.dartlang.org/guides/language/effective-dart/usage#do-use-collection-literals-when-possible
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.schedule),
                ),
                Center(
                  child: Text(
                    schedule.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}