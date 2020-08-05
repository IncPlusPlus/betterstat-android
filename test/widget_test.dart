import 'package:async_redux/async_redux.dart';
import 'package:betterstatmobile/main.dart';
import 'package:betterstatmobile_business_logic/models/app_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should work', (WidgetTester tester) async {
    var store = Store<AppState>(initialState: AppState.initialState());
    await tester.pumpWidget(BetterstatApp(
      store: store,
    ));
  });
}
