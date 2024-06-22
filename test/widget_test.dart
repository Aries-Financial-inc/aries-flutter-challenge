// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_challenge/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  testWidgets('Profit/loss graph is properly displayed',
      (WidgetTester tester) async {
    final optionsData = [
      {
        "strike_price": 100,
        "type": "Call",
        "bid": 10.05,
        "ask": 12.04,
        "long_short": "long",
        "expiration_date": "2025-12-17T00:00:00Z"
      },
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: OptionsCalculator(optionsData: optionsData),
      ),
    );

    expect(find.text('Options Profit Calculator'), findsOneWidget);
    expect(find.byType(SfCartesianChart), findsOneWidget);
  });
}
