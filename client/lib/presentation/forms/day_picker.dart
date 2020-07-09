import 'dart:async';

import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:betterstatmobile_business_logic/models/day.dart';
import 'package:betterstatmobile_client_components/presentation/day_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

const double _kTimePickerHeaderPortraitHeight = 96.0;
const double _kTimePickerHeaderLandscapeWidth = 168.0;

const double _kTimePickerWidthPortrait = 328.0;
const double _kTimePickerWidthLandscape = 512.0;

const double _kTimePickerHeightPortrait = 496.0;
const double _kTimePickerHeightLandscape = 316.0;

const double _kTimePickerHeightPortraitCollapsed = 484.0;
const double _kTimePickerHeightLandscapeCollapsed = 304.0;

const Duration _kVibrateCommitDelay = Duration(milliseconds: 100);
const BoxConstraints _kMinTappableRegion =
    BoxConstraints(minWidth: 48, minHeight: 48);

class _DayPickerHeader extends StatefulWidget {
  const _DayPickerHeader({
    @required this.selectedDay,
    @required this.orientation,
    @required this.onChanged,
    @required this.daysAvailable,
  })  : assert(orientation != null),
        assert(daysAvailable != null);

  final Day selectedDay;
  final Orientation orientation;
  final ValueChanged<Day> onChanged;
  final List<Day> daysAvailable;

  TextStyle _getBaseHeaderStyle(TextTheme headerTextTheme) {
    // These font sizes aren't listed in the spec explicitly. I worked them out
    // by measuring the text using a screen ruler and comparing them to the
    // screen shots of the time picker in the spec.
    assert(orientation != null);
    switch (orientation) {
      case Orientation.portrait:
        return headerTextTheme.headline2.copyWith(fontSize: 60.0);
      case Orientation.landscape:
        return headerTextTheme.headline3.copyWith(fontSize: 50.0);
    }
    return null;
  }

  @override
  State<StatefulWidget> createState() => _DayPickerHeaderState();
}

class _DayPickerHeaderState extends State<_DayPickerHeader> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final ThemeData themeData = Theme.of(context);
    final MediaQueryData media = MediaQuery.of(context);
//    final TimeOfDayFormat timeOfDayFormat = MaterialLocalizations.of(context)
//        .timeOfDayFormat(alwaysUse24HourFormat: media.alwaysUse24HourFormat);

    EdgeInsets padding;
    double height;
    double width;

    assert(widget.orientation != null);
    switch (widget.orientation) {
      case Orientation.portrait:
        height = _kTimePickerHeaderPortraitHeight;
        padding = const EdgeInsets.symmetric(horizontal: 24.0);
        break;
      case Orientation.landscape:
        width = _kTimePickerHeaderLandscapeWidth;
        padding = const EdgeInsets.symmetric(horizontal: 16.0);
        break;
    }

    Color backgroundColor;
    switch (themeData.brightness) {
      case Brightness.light:
        backgroundColor = themeData.primaryColor;
        break;
      case Brightness.dark:
        backgroundColor = themeData.backgroundColor;
        break;
    }

    Color activeColor;
    Color inactiveColor;
    switch (themeData.primaryColorBrightness) {
      case Brightness.light:
        activeColor = Colors.black87;
        inactiveColor = Colors.black54;
        break;
      case Brightness.dark:
        activeColor = Colors.white;
        inactiveColor = Colors.white70;
        break;
    }

//    final TextTheme headerTextTheme = themeData.primaryTextTheme;
//    final TextStyle baseHeaderStyle = _getBaseHeaderStyle(headerTextTheme);
//    final _TimePickerFragmentContext fragmentContext = _TimePickerFragmentContext(
//      headerTextTheme: headerTextTheme,
//      textDirection: Directionality.of(context),
//      selectedDay: selectedDay,
//      mode: mode,
//      activeColor: activeColor,
//      activeStyle: baseHeaderStyle.copyWith(color: activeColor),
//      inactiveColor: inactiveColor,
//      inactiveStyle: baseHeaderStyle.copyWith(color: inactiveColor),
//      onTimeChange: onChanged,
//      onModeChange: _handleChangeMode,
//      targetPlatform: themeData.platform,
//      use24HourDials: use24HourDials,
//    );
//
//    final _DayPickerHeaderFormat format = _buildHeaderFormat(timeOfDayFormat, fragmentContext, orientation);

    Day _daySelected = widget.selectedDay;

    return Container(
      width: width,
      height: height,
//      padding: padding,
      color: backgroundColor,
      child: ListView.builder(
          itemCount: widget.daysAvailable.length,
//          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return RadioListTile(
              title: Text(widget.daysAvailable[index].name),
              value: widget.daysAvailable[index],
              onChanged: (Day value) {
                setState(() {
                  widget.onChanged(value);
//                  _daySelected = value;
                });
              },
              groupValue: _daySelected,
            );
          }),
    );
  }
}

/// A material design time picker designed to appear inside a popup dialog.
///
/// Pass this widget to [showDialog]. The value returned by [showDialog] is the
/// selected [TimeOfDay] if the user taps the "OK" button, or null if the user
/// taps the "CANCEL" button. The selected time is reported by calling
/// [Navigator.pop].
class _DayPickerDialog extends StatefulWidget {
  /// Creates a material day picker.
  ///
  /// [initialDay] must not be null.
  const _DayPickerDialog({
    Key key,
    @required this.initialDay,
    @required this.daysAvailable,
  })  : assert(daysAvailable != null),
        super(key: key);

  /// The days available to select from
  final List<Day> daysAvailable;

  /// The day initially selected when the dialog is shown.
  final Day initialDay;

  @override
  _DayPickerDialogState createState() => _DayPickerDialogState();
}

class _DayPickerDialogState extends State<_DayPickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDay;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
  }

  Day get selectedDay => _selectedDay;
  Day _selectedDay;

  Timer _vibrateTimer;
  MaterialLocalizations localizations;

  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        _vibrateTimer?.cancel();
        _vibrateTimer = Timer(_kVibrateCommitDelay, () {
          HapticFeedback.vibrate();
          _vibrateTimer = null;
        });
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
    }
  }

  void _handleDayChanged(Day value) {
    _vibrate();
    setState(() {
      _selectedDay = value;
    });
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleOk() {
    Navigator.pop(context, _selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final media = MediaQuery.of(context);
    final timeOfDayFormat = localizations.timeOfDayFormat(
        alwaysUse24HourFormat: media.alwaysUse24HourFormat);
    final use24HourDials = hourFormat(of: timeOfDayFormat) != HourFormat.h;
    final theme = Theme.of(context);

    final Widget picker = Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: (selectedDay != null)
            ? buildDayDetailsScreen(context, selectedDay)
            : Text('picker widget'),
      ),
    );

    final Widget actions = ButtonBar(
      children: <Widget>[
        FlatButton(
          child: Text(localizations.cancelButtonLabel),
          onPressed: _handleCancel,
        ),
        FlatButton(
          child: Text(localizations.okButtonLabel),
          onPressed: _handleOk,
        ),
      ],
    );

    final dialog = Dialog(
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        final Widget header = _DayPickerHeader(
          selectedDay: _selectedDay,
          daysAvailable: widget.daysAvailable,
          orientation: orientation,
          onChanged: _handleDayChanged,
        );

        final Widget pickerAndActions = Container(
          color: theme.dialogBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(child: picker),
              // picker grows and shrinks with the available space
              actions,
            ],
          ),
        );

        double timePickerHeightPortrait;
        double timePickerHeightLandscape;
        switch (theme.materialTapTargetSize) {
          case MaterialTapTargetSize.padded:
            timePickerHeightPortrait = _kTimePickerHeightPortrait;
            timePickerHeightLandscape = _kTimePickerHeightLandscape;
            break;
          case MaterialTapTargetSize.shrinkWrap:
            timePickerHeightPortrait = _kTimePickerHeightPortraitCollapsed;
            timePickerHeightLandscape = _kTimePickerHeightLandscapeCollapsed;
            break;
        }

        assert(orientation != null);
        switch (orientation) {
          case Orientation.portrait:
            return SizedBox(
              width: _kTimePickerWidthPortrait,
              height: timePickerHeightPortrait,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  header,
                  Expanded(
                    child: pickerAndActions,
                  ),
                ],
              ),
            );
          case Orientation.landscape:
            return SizedBox(
              width: _kTimePickerWidthLandscape,
              height: timePickerHeightLandscape,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  header,
                  Flexible(
                    child: pickerAndActions,
                  ),
                ],
              ),
            );
        }
        return null;
      }),
    );

    return Theme(
      data: theme.copyWith(
        dialogBackgroundColor: Colors.transparent,
      ),
      child: dialog,
    );
  }

  @override
  void dispose() {
    _vibrateTimer?.cancel();
    _vibrateTimer = null;
    super.dispose();
  }
}

Future<Day> showDayPicker({
  @required BuildContext context,
  @required Day initialDay,
  TransitionBuilder builder,
  bool useRootNavigator = true,
  RouteSettings routeSettings,
}) async {
  assert(context != null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMaterialLocalizations(context));

  final Widget dialog = StoreConnection<AppState, AppActions, List<Day>>(
    builder: (context, state, actions) {
      return _DayPickerDialog(
        initialDay: initialDay,
        daysAvailable: state,
      );
    },
    connect: (AppState state) {
      return state.days.asList();
    },
  );

  return await showDialog<Day>(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    routeSettings: routeSettings,
  );
}
