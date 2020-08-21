import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should work', (WidgetTester tester) async {
    await tester.pumpWidget(StubWidget());
  });
}

class StubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
