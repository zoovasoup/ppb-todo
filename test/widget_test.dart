import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app2/main.dart';

void main() {
  testWidgets('renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.text('test'), findsOneWidget);
  });
}
