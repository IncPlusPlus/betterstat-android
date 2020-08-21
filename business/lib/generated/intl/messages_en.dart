// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(name) => "Deleted \"${name}\"";

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "addDay": MessageLookupByLibrary.simpleMessage("Add Day"),
        "addSchedule": MessageLookupByLibrary.simpleMessage("Add Schedule"),
        "addThermostat": MessageLookupByLibrary.simpleMessage("Add Thermostat"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Betterstat"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "dayDetails": MessageLookupByLibrary.simpleMessage("Day Details"),
        "days": MessageLookupByLibrary.simpleMessage("Days"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteDay": MessageLookupByLibrary.simpleMessage("Delete Day"),
        "deleteDayConfirmation":
            MessageLookupByLibrary.simpleMessage("Delete this day?"),
        "deleteSchedule":
            MessageLookupByLibrary.simpleMessage("Delete Schedule"),
        "deleteScheduleConfirmation":
            MessageLookupByLibrary.simpleMessage("Delete this schedule?"),
        "deleteThermostat":
            MessageLookupByLibrary.simpleMessage("Delete Thermostat"),
        "deleteThermostatConfirmation":
            MessageLookupByLibrary.simpleMessage("Delete this thermostat?"),
        "editDay": MessageLookupByLibrary.simpleMessage("Edit Day"),
        "editSchedule": MessageLookupByLibrary.simpleMessage("Edit Schedule"),
        "editThermostat":
            MessageLookupByLibrary.simpleMessage("Edit Thermostat"),
        "emptyTextFieldError":
            MessageLookupByLibrary.simpleMessage("Please enter some text"),
        "itemDeleted": m0,
        "newDayHint": MessageLookupByLibrary.simpleMessage(
            "What should this day be named?"),
        "newScheduleHint":
            MessageLookupByLibrary.simpleMessage("Schedule name"),
        "newThermostatHint":
            MessageLookupByLibrary.simpleMessage("Thermostat name"),
        "saveChanges": MessageLookupByLibrary.simpleMessage("Save changes"),
        "scheduleDetails":
            MessageLookupByLibrary.simpleMessage("Schedule Details"),
        "schedules": MessageLookupByLibrary.simpleMessage("Schedules"),
        "stats": MessageLookupByLibrary.simpleMessage("Stats"),
        "thermostatDetails":
            MessageLookupByLibrary.simpleMessage("Thermostat Details"),
        "thermostats": MessageLookupByLibrary.simpleMessage("Thermostats"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo")
      };
}
