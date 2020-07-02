import 'package:betterstatmobile/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should work', (WidgetTester tester) async {
    await tester.pumpWidget(BetterstatApp());
  });
}
