// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Betterstat`
  String get appTitle {
    return Intl.message(
      'Betterstat',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Deleted "{name}"`
  String itemDeleted(Object name) {
    return Intl.message(
      'Deleted "$name"',
      name: 'itemDeleted',
      desc: '',
      args: [name],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get emptyTextFieldError {
    return Intl.message(
      'Please enter some text',
      name: 'emptyTextFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Add Thermostat`
  String get addThermostat {
    return Intl.message(
      'Add Thermostat',
      name: 'addThermostat',
      desc: '',
      args: [],
    );
  }

  /// `Delete Thermostat`
  String get deleteThermostat {
    return Intl.message(
      'Delete Thermostat',
      name: 'deleteThermostat',
      desc: '',
      args: [],
    );
  }

  /// `Delete this thermostat?`
  String get deleteThermostatConfirmation {
    return Intl.message(
      'Delete this thermostat?',
      name: 'deleteThermostatConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Thermostat`
  String get editThermostat {
    return Intl.message(
      'Edit Thermostat',
      name: 'editThermostat',
      desc: '',
      args: [],
    );
  }

  /// `Thermostat name`
  String get newThermostatHint {
    return Intl.message(
      'Thermostat name',
      name: 'newThermostatHint',
      desc: '',
      args: [],
    );
  }

  /// `Thermostat Details`
  String get thermostatDetails {
    return Intl.message(
      'Thermostat Details',
      name: 'thermostatDetails',
      desc: '',
      args: [],
    );
  }

  /// `Thermostats`
  String get thermostats {
    return Intl.message(
      'Thermostats',
      name: 'thermostats',
      desc: '',
      args: [],
    );
  }

  /// `Add Schedule`
  String get addSchedule {
    return Intl.message(
      'Add Schedule',
      name: 'addSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Delete Schedule`
  String get deleteSchedule {
    return Intl.message(
      'Delete Schedule',
      name: 'deleteSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Delete this schedule?`
  String get deleteScheduleConfirmation {
    return Intl.message(
      'Delete this schedule?',
      name: 'deleteScheduleConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Schedule`
  String get editSchedule {
    return Intl.message(
      'Edit Schedule',
      name: 'editSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Schedule name`
  String get newScheduleHint {
    return Intl.message(
      'Schedule name',
      name: 'newScheduleHint',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Details`
  String get scheduleDetails {
    return Intl.message(
      'Schedule Details',
      name: 'scheduleDetails',
      desc: '',
      args: [],
    );
  }

  /// `Schedules`
  String get schedules {
    return Intl.message(
      'Schedules',
      name: 'schedules',
      desc: '',
      args: [],
    );
  }

  /// `Add Day`
  String get addDay {
    return Intl.message(
      'Add Day',
      name: 'addDay',
      desc: '',
      args: [],
    );
  }

  /// `Delete Day`
  String get deleteDay {
    return Intl.message(
      'Delete Day',
      name: 'deleteDay',
      desc: '',
      args: [],
    );
  }

  /// `Delete this day?`
  String get deleteDayConfirmation {
    return Intl.message(
      'Delete this day?',
      name: 'deleteDayConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Day`
  String get editDay {
    return Intl.message(
      'Edit Day',
      name: 'editDay',
      desc: '',
      args: [],
    );
  }

  /// `What should this day be named?`
  String get newDayHint {
    return Intl.message(
      'What should this day be named?',
      name: 'newDayHint',
      desc: '',
      args: [],
    );
  }

  /// `Day Details`
  String get dayDetails {
    return Intl.message(
      'Day Details',
      name: 'dayDetails',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get stats {
    return Intl.message(
      'Stats',
      name: 'stats',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
