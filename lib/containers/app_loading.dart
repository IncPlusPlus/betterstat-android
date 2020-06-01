import 'package:betterstatmobile/actions/actions.dart';
import 'package:betterstatmobile/containers/typedefs.dart';
import 'package:betterstatmobile/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class AppLoading extends StoreConnector<AppState, AppActions, bool> {
  final ViewModelBuilder<bool> builder;

  AppLoading({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context, bool state, AppActions actions) {
    return builder(context, state);
  }

  @override
  bool connect(AppState state) {
    return state.isLoading;
  }
}