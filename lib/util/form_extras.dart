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
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
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

//class LocalTimeFormFieldState extends State<FormField<LocalTime>> {
//}
