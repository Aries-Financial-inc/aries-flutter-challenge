// // options_strategy_repository_test.dart
//
// import 'package:flutter_challenge/models/option_contract.dart';
// import 'package:flutter_challenge/repositories/options_strategy_repository.dart';
// import 'package:flutter_challenge/utils/option_calculator.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// // options_strategy_repository_test.dart
// class MockOptionCalculator extends Mock implements OptionCalculator {}
//
// void main() {
//   late OptionsStrategyRepository repository;
//   late MockOptionCalculator mockCalculator;
//
//   setUp(() {
//     mockCalculator = MockOptionCalculator();
//     repository = OptionsStrategyRepository();
//   });
//
//   test('generateGraphData returns correct graph data', () {
//     when(mockCalculator.calculateGraphPoints(any)).thenReturn([
//       const FlSpot(100, 50),
//       const FlSpot(110, 60),
//     ]);
//
//     final result = repository.generateGraphData([mockCallContract]);
//
//     expect(result, isA<List<FlSpot>>());
//     expect(result, hasLength(2));
//     expect(result[0].x, 100);
//     expect(result[0].y, 50);
//   });
//
//   test('calculateMaxProfit returns correct max profit', () {
//     when(mockCalculator.getMaxProfit(any)).thenReturn(150.0);
//
//     final result = repository.calculateMaxProfit([mockCallContract]);
//
//     expect(result, equals(150.0));
//   });
//
//   test('calculateMaxLoss returns correct max loss', () {
//     when(mockCalculator.getMaxLoss(any)).thenReturn(-50.0);
//
//     final result = repository.calculateMaxLoss([mockCallContract]);
//
//     expect(result, equals(-50.0));
//   });
//
//   test('calculateBreakEvenPoints returns correct break even points', () {
//     when(mockCalculator.getBreakEvenPoints(any)).thenReturn([100.0, 110.0]);
//
//     final result = repository.calculateBreakEvenPoints([mockCallContract]);
//
//     expect(result, isA<List<double>>());
//     expect(result, hasLength(2));
//     expect(result[0], equals(100.0));
//     expect(result[1], equals(110.0));
//   });
// }
//
// // option_contract_mock.dart
//
// OptionContract mockCallContract = OptionContract(
//   type: OptionType.call,
//   strikePrice: 100.0,
//   bid: 10.0,
//   ask: 12.0,
//   longShort: LongShort.long,
//   expirationDate: DateTime(2024, 12, 20),
// );
//
// OptionContract mockPutContract = OptionContract(
//   type: OptionType.put,
//   strikePrice: 90.0,
//   bid: 5.0,
//   ask: 7.0,
//   longShort: LongShort.short,
//   expirationDate: DateTime(2024, 12, 20),
// );
