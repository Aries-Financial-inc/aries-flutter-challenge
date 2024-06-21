import 'package:flutter_challenge/constants/strings.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_challenge/main.dart';

void main() {
  testWidgets('Screen loaded test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text(StringValues.title), findsOneWidget);
    expect(find.text('Some random String'), findsNothing);
    expect(find.text(StringValues.metricsTitle), findsOneWidget);
  });
}
