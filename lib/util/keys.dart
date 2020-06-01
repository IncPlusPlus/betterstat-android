import 'package:flutter/widgets.dart';

class BetterstatKeys {

  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addTodoFab = Key('__addTodoFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Todos
  static const todoList = Key('__todoList__');
  static const todosLoading = Key('__todosLoading__');
  static final todoItem = (String id) => Key('TodoItem__${id}');
  static final todoItemCheckbox =
      (String id) => Key('TodoItem__${id}__Checkbox');
  static final scheduleItemName = (String id) => Key('ScheduleItem__${id}__Name');
//  static final todoItemNote = (String id) => Key('TodoItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const scheduleTab = Key('__scheduleTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editScheduleFab = Key('__editScheduleFab__');
  static const deleteScheduleButton = Key('__deleteScheduleFab__');
  static const scheduleDetailsScreen = Key('__scheduleDetailsScreen__');
  static final detailsTodoItemCheckbox = Key('DetailsTodo__Checkbox');
  static final detailsScheduleItemName = Key('DetailsSchedule__Name');
  static final detailsTodoItemNote = Key('DetailsTodo__Note');

  // Add Screen
  static const addScheduleScreen = Key('__addScheduleScreen__');
  static const saveNewSchedule = Key('__saveNewSchedule__');
  static const nameField = Key('__nameField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editScheduleScreen = Key('__editScheduleScreen__');
  static const saveScheduleFab = Key('__saveScheduleFab__');
}