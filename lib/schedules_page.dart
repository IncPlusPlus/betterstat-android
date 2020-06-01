import 'package:betterstatmobile/api/schedule/api_schedule.dart';
import 'package:betterstatmobile/containers/edit_schedule.dart';
import 'package:betterstatmobile/schedule_tile.dart';
import 'package:betterstatmobile/models/schedule.dart';
import 'package:flutter/material.dart';


class SchedulesPage extends StatefulWidget {

  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
//  Schedule _defaultSchedule;
//  Schedule _currentSchedule;
  // Widgets are supposed to be deeply immutable objects. We can update and edit
  // _categories as we build our app, and when we pass it into a widget's
  // `children` property, we call .toList() on it.
  // For more details, see https://github.com/dart-lang/sdk/issues/27755
  List<Schedule> _schedules = <Schedule>[];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We only want to load our data in once
    if (_schedules.isEmpty) {
      await _retrieveApiSchedules();
    }
  }


  /// Retrieves a [Category] and its [Unit]s from an API on the web
  Future<void> _retrieveApiSchedules() async {
    final schedulesList = await getSchedules();
    // If the API errors out or we have no internet connection, this category
    // remains in placeholder mode (disabled)
    if (schedulesList != null) {
      setState(() {
        _schedules=schedulesList;
      });
    }
  }

  /// Function to call when a [Schedule] is tapped.
  void _onScheduleTap(Schedule schedule) {
    setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditSchedule(schedule: schedule,)),
            );
          });
  }

  /// Makes the correct number of rows for the list view, based on whether the
  /// device is portrait or landscape.
  ///
  /// For portrait, we use a [ListView]. For landscape, we use a [GridView].
  Widget _buildScheduleWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ScheduleTile(
            schedule: _schedules[index],
            onTap: _onScheduleTap,
          );
        },
        itemCount: _schedules.length,
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _schedules.map((Schedule s) {
          return ScheduleTile(
            schedule: s,
            onTap: _onScheduleTap,
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_schedules.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Based on the device size, figure out how to best lay out the list
    // You can also use MediaQuery.of(context).size to calculate the orientation
    assert(debugCheckHasMediaQuery(context));
    final listView = Container(color: Theme.of(context).canvasColor,child:Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildScheduleWidgets(MediaQuery.of(context).orientation),
    ));
    return RefreshIndicator(onRefresh: () async { await _retrieveApiSchedules(); },
    child: listView);
  }
}