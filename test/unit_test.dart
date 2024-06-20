import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/option_contract.dart';

void main() {
  group('OptionsTest', () {
    test('calculateProfitLoss for a single call option', () {
      final contracts = [
        OptionContract(
          strikePrice: 100,
          premium: 10,
          isCall: true,
          isLong: true,
        ),
      ];

      expect(contracts.calculateProfitLoss(110), 0);
      expect(contracts.calculateProfitLoss(120), 10);
      expect(contracts.calculateProfitLoss(90), -10);
    });

    test('calculateProfitLoss for a single put option', () {
      final contracts = [
        OptionContract(
          strikePrice: 100,
          premium: 10,
          isCall: false,
          isLong: true,
        ),
      ];

      expect(contracts.calculateProfitLoss(90), 0);
      expect(contracts.calculateProfitLoss(80), 10);
      expect(contracts.calculateProfitLoss(110), -10);
    });

    test('getBreakEvenPoints', () {
      final contracts = [
        OptionContract(
          strikePrice: 100,
          premium: 10,
          isCall: true,
          isLong: true,
        ),
        OptionContract(
          strikePrice: 110,
          premium: 5,
          isCall: false,
          isLong: false,
        ),
      ];

      final breakEvenPoints = contracts.getBreakEvenPoints();
      expect(breakEvenPoints, [110, 105]);
    });

    test('getMaxProfit', () {
      final contracts = [
        OptionContract(
          strikePrice: 100,
          premium: 10,
          isCall: true,
          isLong: true,
        ),
        OptionContract(
          strikePrice: 110,
          premium: 5,
          isCall: false,
          isLong: false,
        ),
      ];

      expect(contracts.getMaxProfit(), 90);
    });

    test('getMaxLoss', () {
      final contracts = [
        OptionContract(
          strikePrice: 100,
          premium: 10,
          isCall: true,
          isLong: true,
        ),
        OptionContract(
          strikePrice: 110,
          premium: 5,
          isCall: false,
          isLong: false,
        ),
      ];

      expect(contracts.getMaxLoss(), 15);
    });
  });
}
