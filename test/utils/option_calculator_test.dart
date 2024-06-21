import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_challenge/data_models/data_models.dart';
import 'package:flutter_challenge/util/option_calculator.dart';

void main() {
  group('OptionCalculator', () {
    late OptionCalculator calculator;
    late List<OptionContract> options;

    setUp(() {
      calculator = OptionCalculator();
      options = const [
        OptionContract(
          strikePrice: 100,
          type: OptionType.Call,
          longShort: LongShort.long,
          bid: 10.05,
          ask: 12.04,
        ),
        OptionContract(
          strikePrice: 102.50,
          type: OptionType.Call,
          longShort: LongShort.long,
          bid: 12.10,
          ask: 14,
        ),
        OptionContract(
          strikePrice: 103,
          type: OptionType.Put,
          longShort: LongShort.short,
          bid: 14,
          ask: 15.50,
        ),
        OptionContract(
          strikePrice: 105,
          type: OptionType.Put,
          longShort: LongShort.long,
          bid: 16,
          ask: 18,
        ),
      ];
    });

    test('calculateTotalProfitLoss for no options returns zero profit/loss',
        () {
      final emptyOptions = <OptionContract>[];
      final result =
          calculator.calculateTotalProfitLoss(emptyOptions, 80, 120, 0.2);
      expect(result.every((data) => data['profitLoss'] == 0), true);
    });

    test('findMaxMinProfitLoss returns correct max profit and max loss', () {
      final profitLossData =
          calculator.calculateTotalProfitLoss(options, 80, 120, 0.2);
      final result = calculator.findMaxMinProfitLoss(profitLossData);
      expect(result['maxProfit']! >= result['maxLoss']!, true);
    });

    test('findMaxMinProfitLoss with no profit/loss data returns infinities',
        () {
      final emptyProfitLossData = <Map<String, double>>[];
      final result = calculator.findMaxMinProfitLoss(emptyProfitLossData);
      expect(result['maxProfit'], double.negativeInfinity);
      expect(result['maxLoss'], double.infinity);
    });

    test('findBreakEvenPoints returns correct break-even points', () {
      final profitLossData =
          calculator.calculateTotalProfitLoss(options, 80, 120, 0.2);
      final result = calculator.findBreakEvenPoints(profitLossData);
      expect(result.isNotEmpty, true);
      expect(result.every((point) => point >= 80 && point <= 120), true);
    });

    test('findBreakEvenPoints with no profit/loss data returns empty list', () {
      final emptyProfitLossData = <Map<String, double>>[];
      final result = calculator.findBreakEvenPoints(emptyProfitLossData);
      expect(result.isEmpty, true);
    });
  });
}
