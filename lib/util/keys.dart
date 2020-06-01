import 'package:flutter/widgets.dart';

class BetterstatKeys {

  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addScheduleFab = Key('__addScheduleFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Schedules
  static const scheduleList = Key('__scheduleList__');
  static const schedulesLoading = Key('__schedulesLoading__');
  static final scheduleItem = (String id) => Key('ScheduleItem__${id}');
  static final scheduleItemName = (String id) => Key('ScheduleItem__${id}__Name');

  // Tabs
  static const tabs = Key('__tabs__');
  static const scheduleTab = Key('__scheduleTab__');
  static const statsTab = Key('__statsTab__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editScheduleFab = Key('__editScheduleFab__');
  static const deleteScheduleButton = Key('__deleteScheduleFab__');
  static const scheduleDetailsScreen = Key('__scheduleDetailsScreen__');
  static final detailsScheduleItemName = Key('DetailsSchedule__Name');

  // Add Screen
  static const addScheduleScreen = Key('__addScheduleScreen__');
  static const saveNewSchedule = Key('__saveNewSchedule__');
  static const nameField = Key('__nameField__');

  // Edit Screen
  static const editScheduleScreen = Key('__editScheduleScreen__');
  static const saveScheduleFab = Key('__saveScheduleFab__');
}