import 'dart:async';

import 'package:betterstatmobile/localizations/messages_all.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class BetterstatLocalizations {
  final Locale locale;

  BetterstatLocalizations(this.locale);

  String get activeSchedules => Intl.message(
        'Active Schedules',
        name: 'activeSchedules',
        args: [],
        locale: locale.toString(),
      );

  String get addSchedule => Intl.message(
        'Add Schedule',
        name: 'addSchedule',
        args: [],
        locale: locale.toString(),
      );

  String get appTitle => Intl.message(
        'Betterstat',
        name: 'appTitle',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get completedSchedules => Intl.message(
        'Completed Schedules',
        name: 'completedSchedules',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get deleteSchedule => Intl.message(
        'Delete Schedule',
        name: 'deleteSchedule',
        args: [],
        locale: locale.toString(),
      );

  String get deleteScheduleConfirmation => Intl.message(
        'Delete this schedule?',
        name: 'deleteScheduleConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get editSchedule => Intl.message(
        'Edit Schedule',
        name: 'editSchedule',
        args: [],
        locale: locale.toString(),
      );

  String get emptyScheduleError => Intl.message(
        'Please enter some text',
        name: 'emptyScheduleError',
        args: [],
        locale: locale.toString(),
      );

  String get filterSchedules => Intl.message(
        'Filter Schedules',
        name: 'filterSchedules',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get newScheduleHint => Intl.message(
        'What needs to be done?',
        name: 'newScheduleHint',
        args: [],
        locale: locale.toString(),
      );

  String get notesHint => Intl.message(
        'Additional Notes...',
        name: 'notesHint',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get scheduleDetails => Intl.message(
        'Schedule Details',
        name: 'scheduleDetails',
        args: [],
        locale: locale.toString(),
      );

  String get schedules => Intl.message(
        'Schedules',
        name: 'schedules',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String scheduleDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'scheduleDeleted',
        args: [task],
        locale: locale.toString(),
      );

  static Future<BetterstatLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return BetterstatLocalizations(locale);
    });
  }

  static BetterstatLocalizations of(BuildContext context) {
    return Localizations.of<BetterstatLocalizations>(
        context, BetterstatLocalizations);
  }
}

class BetterstatLocalizationsDelegate
    extends LocalizationsDelegate<BetterstatLocalizations> {
  const BetterstatLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<BetterstatLocalizations> load(Locale locale) =>
      BetterstatLocalizations.load(locale);

  @override
  bool shouldReload(BetterstatLocalizationsDelegate old) => false;
}
