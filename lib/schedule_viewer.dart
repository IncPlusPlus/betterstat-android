//import 'package:betterstatmobile/models/schedule.dart';
//import 'package:betterstatmobile/schedule_editor.dart';
//import 'package:flutter/material.dart';
//
//const _padding = EdgeInsets.all(16.0);
//
//class ScheduleViewer extends StatefulWidget {
//  /// The current [Schedule] for unit conversion.
//  final Schedule schedule;
//
//  /// This [ScheduleViewer] takes in a [Schedule]. It can't be null.
//  const ScheduleViewer({
//    @required this.schedule,
//  }) : assert(schedule != null);
//
//  @override
//  _ScheduleViewerState createState() => _ScheduleViewerState();
//}
//
//class _ScheduleViewerState extends State<ScheduleViewer> {
//  static final time = Padding(
//    padding: _padding,
//    child: Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: [
//        // This is the widget that accepts text input. In this case, it
//        // accepts numbers and calls the onChanged property on update.
//        // You can read more about it here: https://flutter.io/text-input
//        InkWell(
//          child: Center(child: Text('Sample text',textScaleFactor: 2.0,),),
//          onTap: () => print("Text pressed"),
//        ),
//      ],
//    ),
//  );
//
//  static final arrows = RotatedBox(
//    quarterTurns: 1,
//    child: Icon(
//      Icons.compare_arrows,
//      size: 40.0,
//    ),
//  );
//
//  static final setPoint = Padding(
//    padding: _padding,
//    child: Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: [
//        // This is the widget that accepts text input. In this case, it
//        // accepts numbers and calls the onChanged property on update.
//        // You can read more about it here: https://flutter.io/text-input
//        InkWell(
//          child: Text('Sample text'),
//          onTap: () => print("Text pressed"),
//        ),
//      ],
//    ),
//  );
//
//  final converter = ListView(
//    children: [
//      time,
//      arrows,
//      setPoint,
//    ],
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    // Based on the orientation of the parent widget, figure out how to best
//    // lay out our converter.
//    return Padding(
//      padding: _padding,
//      child: OrientationBuilder(
//        builder: (BuildContext context, Orientation orientation) {
//          if (orientation == Orientation.portrait) {
//            return ScheduleEditor(schedule: widget.schedule,);
//          } else {
//            return Center(
//              child: Container(
//                width: 450.0,
//                child: ScheduleEditor(schedule: widget.schedule,),
//              ),
//            );
//          }
//        },
//      ),
//    );
//  }
//}
