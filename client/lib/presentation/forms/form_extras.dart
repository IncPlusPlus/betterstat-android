import 'package:auto_size_text/auto_size_text.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_client_components/presentation/forms/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_machine/time_machine.dart';

void pickTime(LocalTime time, FormFieldState<LocalTime> state) {
  showTimePicker(
    initialTime: TimeOfDay(hour: time.hourOfDay, minute: time.minuteOfHour),
    context: state.context,
  ).then((value) {
    if (value != null) {
      state.didChange(LocalTime(value.hour, value.minute, 0));
    }
  });
}

class LocalTimeFormField extends FormField<LocalTime> {
  LocalTimeFormField({
    FormFieldSetter<LocalTime> onSaved,
    FormFieldValidator<LocalTime> validator,
    LocalTime initialValue,
    bool autoValidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autoValidate,
            builder: (FormFieldState<LocalTime> state) {
              return InkWell(
                child: Center(
                  child: Text(
                    state.value.toString('hh:mm tt'),
                    style: Theme.of(state.context).textTheme.headline5,
                  ),
                ),
                onTap: () => pickTime(state.value, state),
              );
            });
}

class DaySelectionFormField extends FormField<Day> {
  DaySelectionFormField({
    FormFieldSetter<Day> onSaved,
    FormFieldValidator<Day> validator,
    Day initialValue,
    bool autoValidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autoValidate,
            builder: (FormFieldState<Day> state) {
              return InkWell(
                child: Center(
                  child: AutoSizeText(
                    (state.value != null) ? state.value.name : 'No day',
                    style: TextStyle(fontSize: 30),
                    maxLines: 2,
                    overflowReplacement: Text('Day name too long'),
                  ),
                ),
                onTap: () => pickDay(state.value, state),
              );
            });

  static void pickDay(Day initialDay, FormFieldState<Day> state) {
    showDayPicker(initialDay: initialDay, context: state.context)
        .then((value) => {
              if (value != null) {state.didChange(value)}
            });
  }
}
