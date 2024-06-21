import 'package:flutter_challenge/risk_reward_graph/model/option_analysis_result.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/services/options_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OptionsCalculatorService', () {
    test('calculateProfitLoss calculates correct overall results', () {
      // Create a list of OptionContractModel for testing
      List<OptionContractModel> optionsData = [
        OptionContractModel(
          strikePrice: 100.0,
          type: OptionType.call,
          position: OptionPosition.long,
          bid: 1.0,
          ask: 2.0,
          expirationDate: '2024-12-31',
        ),
        OptionContractModel(
          strikePrice: 110.0,
          type: OptionType.put,
          position: OptionPosition.short,
          bid: 2.0,
          ask: 3.0,
          expirationDate: '2024-12-31',
        ),
      ];

      // Call the calculateProfitLoss method
      OptionsAnalysisResult result =
          OptionsCalculatorService.calculateProfitLoss(optionsData);

      // Assert expected outcomes

      expect(result.maxProfit, equals(21.0));
      expect(result.maxLoss, equals(-19.0));

      // Additional assertions can be added based on specific expected behavior
    });

    // Add more test cases as needed to cover edge cases and additional scenarios
  });
}
