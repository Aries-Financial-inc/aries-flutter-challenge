import 'package:flutter_challenge/RiskReward/src/application/risk_reward_service.dart';
import 'package:flutter_challenge/RiskReward/src/domain/option_data.dart';
import 'package:flutter_challenge/RiskReward/src/domain/payoff_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ignore: non_constant_identifier_names
  final riskRewardService = RiskRewardService();

  bool almostEqual(double a, double b, {double epsilon = 1e-2}) {
    return (a - b).abs() < epsilon;
  }

  void expectPayoffData(List<PayoffData> result, List<PayoffData> expected) {
    for (int i = 0; i < result.length; i++) {
      expect(result[i].underlyingPrice, expected[i].underlyingPrice);
      expect(almostEqual(result[i].payoff, expected[i].payoff), true,
          reason:
              'Expected: ${expected[i].payoff}, Actual: ${result[i].payoff}');
    }
  }

  test('Calculate Payoff for Long Call', () {
    var option = OptionData(
      type: 'Call',
      strikePrice: 100,
      bid: 10.05,
      ask: 12.04,
      longShort: 'long',
      expirationDate: DateTime.parse('2025-12-17'),
    );
    var underlyingPrices = [90.0, 100.0, 110.0, 120.0];

    var result = riskRewardService.calculatePayoff(option, underlyingPrices);

    var expected = [
      PayoffData(90, -12.04),
      PayoffData(100, -12.04),
      PayoffData(110, -2.04),
      PayoffData(120, 7.96),
    ];

    expectPayoffData(result, expected);
  });

  test('Calculate Payoff for Short Call', () {
    var option = OptionData(
      type: 'Call',
      strikePrice: 100,
      bid: 10.05,
      ask: 12.04,
      longShort: 'short',
      expirationDate: DateTime.parse('2025-12-17'),
    );
    var underlyingPrices = [90.0, 100.0, 110.0, 120.0];

    var result = riskRewardService.calculatePayoff(option, underlyingPrices);

    var expected = [
      PayoffData(90, 10.05),
      PayoffData(100, 10.05),
      PayoffData(110, 0.05),
      PayoffData(120, -9.95),
    ];

    expectPayoffData(result, expected);
  });

  test('Calculate Payoff for Long Put', () {
    var option = OptionData(
      type: 'Put',
      strikePrice: 100,
      bid: 14,
      ask: 15.50,
      longShort: 'long',
      expirationDate: DateTime.parse('2025-12-17'),
    );
    var underlyingPrices = [90.0, 100.0, 110.0, 120.0];

    var result = riskRewardService.calculatePayoff(option, underlyingPrices);

    var expected = [
      PayoffData(90, -5.50),
      PayoffData(100, -15.50),
      PayoffData(110, -15.50),
      PayoffData(120, -15.50),
    ];

    expectPayoffData(result, expected);
  });

  test('Calculate Payoff for Short Put', () {
    var option = OptionData(
      type: 'Put',
      strikePrice: 100,
      bid: 14,
      ask: 15.50,
      longShort: 'short',
      expirationDate: DateTime.parse('2025-12-17'),
    );
    var underlyingPrices = [90.0, 100.0, 110.0, 120.0];

    var result = riskRewardService.calculatePayoff(option, underlyingPrices);

    var expected = [
      PayoffData(90, 4.0),
      PayoffData(100, 14.0),
      PayoffData(110, 14.0),
      PayoffData(120, 14.0),
    ];

    expectPayoffData(result, expected);
  });

  test('Calculate Combined Payoff for Multiple Options', () {
    var optionsData = [
      OptionData(
        type: 'Call',
        strikePrice: 100,
        bid: 10.05,
        ask: 12.04,
        longShort: 'long',
        expirationDate: DateTime.parse('2025-12-17'),
      ),
      OptionData(
        type: 'Put',
        strikePrice: 105,
        bid: 16.00,
        ask: 18.00,
        longShort: 'short',
        expirationDate: DateTime.parse('2025-12-17'),
      )
    ];

    var minUnderlyingPrice = 90.0;
    var maxUnderlyingPrice = 120.0;

    var result = riskRewardService.calculateCombinedPayoffs(
        optionsData, minUnderlyingPrice, maxUnderlyingPrice);

    // Expected values for verification
    var expected = [
      PayoffData(90, -12.04 + 16),
      PayoffData(100, -12.04 + 16),
      PayoffData(105, -12.04 + 0),
      PayoffData(110, -2.04 + (16 - 5)),
      PayoffData(120, 7.96 + (16 - 15))
    ];

    // Compare the result with expected values at specific points to verify correctness
    expectPayoffData(
        result
            .where((data) => [90.0, 100.0, 105.0, 110.0, 120.0]
                .contains(data.underlyingPrice))
            .toList(),
        expected);
  });
}
