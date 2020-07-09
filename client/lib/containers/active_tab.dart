import 'package:betterstatmobile_business_logic/actions/actions.dart';
import 'package:betterstatmobile_business_logic/models/models.dart';
import 'package:betterstatmobile_client_components/containers/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class ActiveTab extends StoreConnector<AppState, AppActions, AppTab> {
  final ViewModelBuilder<AppTab> builder;

  ActiveTab({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context, AppTab activeTab, AppActions actions) {
    return builder(context, activeTab);
  }

  @override
  AppTab connect(AppState state) => state.activeTab;
}
