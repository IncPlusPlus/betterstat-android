import 'package:flutter/widgets.dart';

class BetterstatKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const snackbar = Key('__snackbar__');
  static var addThermostatFab = Key('__addThermostatFab__');
  static const addScheduleFab = Key('__addScheduleFab__');
  static const addDayFab = Key('__addDayFab__');

  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  //<editor-fold desc="Thermostat">
  static const thermostatList = Key('__thermostatList__');
  static const thermostatsLoading = Key('__thermostatsLoading__');
  static final thermostatItem = (String id) => Key('ThermostatItem__${id}');
  static final thermostatItemName =
      (String id) => Key('ThermostatItem__${id}__Name');

  //</editor-fold>

  //<editor-fold desc="Schedule">
  static const scheduleList = Key('__scheduleList__');
  static const schedulesLoading = Key('__schedulesLoading__');
  static final scheduleItem = (String id) => Key('ScheduleItem__${id}');
  static final scheduleItemName =
      (String id) => Key('ScheduleItem__${id}__Name');

  //</editor-fold>

  //<editor-fold desc="Day">
  static const dayList = Key('__dayList__');
  static const daysLoading = Key('__daysLoading__');
  static final dayItem = (String id) => Key('DayItem__${id}');
  static final dayItemName = (String id) => Key('DayItem__${id}__Name');

  //</editor-fold>

  //<editor-fold desc="Tabs">
  static const tabs = Key('__tabs__');
  static const thermostatTab = Key('__thermostatTab__');
  static const scheduleTab = Key('__scheduleTab__');
  static const dayTab = Key('__dayTab__');
  static const statsTab = Key('__statsTab__');

  //</editor-fold>

  //<editor-fold desc="Stats">
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  //</editor-fold>

  //<editor-fold desc="Details Screen">
  static const editThermostatFab = Key('__editThermostatFab__');
  static const deleteThermostatButton = Key('__deleteThermostatFab__');
  static const thermostatDetailsScreen = Key('__thermostatDetailsScreen__');
  static const editScheduleFab = Key('__editScheduleFab__');
  static const deleteScheduleButton = Key('__deleteScheduleFab__');
  static const scheduleDetailsScreen = Key('__scheduleDetailsScreen__');
  static final detailsScheduleItemName = Key('DetailsSchedule__Name');
  static const editDayFab = Key('__editDayFab__');
  static const deleteDayButton = Key('__deleteDayFab__');
  static const dayDetailsScreen = Key('__dayDetailsScreen__');
  static final detailsDayItemName = Key('DetailsDay__Name');

  //</editor-fold>

  //<editor-fold desc="Add Screen">
  static const addThermostatScreen = Key('__addThermostatScreen__');
  static const saveNewThermostat = Key('__saveNewThermostat__');
  static const addScheduleScreen = Key('__addScheduleScreen__');
  static const saveNewSchedule = Key('__saveNewSchedule__');
  static const addDayScreen = Key('__addDayScreen__');
  static const saveNewDay = Key('__saveNewDay__');
  static const nameField = Key('__nameField__');

  //</editor-fold>

  //<editor-fold desc="Edit Screen">
  static const editThermostatScreen = Key('__editThermostatScreen__');
  static const saveThermostatFab = Key('__saveThermostatFab__');
  static const editScheduleScreen = Key('__editScheduleScreen__');
  static const saveScheduleFab = Key('__saveScheduleFab__');
  static const editDayScreen = Key('__editDayScreen__');
  static const saveDayFab = Key('__saveDayFab__');
//</editor-fold>
}
