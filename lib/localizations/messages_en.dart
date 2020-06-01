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

  static m0(task) => "Deleted \"${task}\"";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "activeSchedules" : MessageLookupByLibrary.simpleMessage("Active Schedules"),
    "addSchedule" : MessageLookupByLibrary.simpleMessage("Add Schedule"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Betterstat"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "clearCompleted" : MessageLookupByLibrary.simpleMessage("Clear completed"),
    "completedSchedules" : MessageLookupByLibrary.simpleMessage("Completed Schedules"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteSchedule" : MessageLookupByLibrary.simpleMessage("Delete Schedule"),
    "deleteScheduleConfirmation" : MessageLookupByLibrary.simpleMessage("Delete this schedule?"),
    "editSchedule" : MessageLookupByLibrary.simpleMessage("Edit Schedule"),
    "emptyScheduleError" : MessageLookupByLibrary.simpleMessage("Please enter some text"),
    "filterSchedules" : MessageLookupByLibrary.simpleMessage("Filter Schedules"),
    "markAllComplete" : MessageLookupByLibrary.simpleMessage("Mark all complete"),
    "markAllIncomplete" : MessageLookupByLibrary.simpleMessage("Mark all incomplete"),
    "newScheduleHint" : MessageLookupByLibrary.simpleMessage("What needs to be done?"),
    "notesHint" : MessageLookupByLibrary.simpleMessage("Additional Notes..."),
    "saveChanges" : MessageLookupByLibrary.simpleMessage("Save changes"),
    "scheduleDeleted" : m0,
    "scheduleDetails" : MessageLookupByLibrary.simpleMessage("Schedule Details"),
    "schedules" : MessageLookupByLibrary.simpleMessage("Schedules"),
    "showActive" : MessageLookupByLibrary.simpleMessage("Show Active"),
    "showAll" : MessageLookupByLibrary.simpleMessage("Show All"),
    "showCompleted" : MessageLookupByLibrary.simpleMessage("Show Completed"),
    "stats" : MessageLookupByLibrary.simpleMessage("Stats"),
    "undo" : MessageLookupByLibrary.simpleMessage("Undo")
  };
}
