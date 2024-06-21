import 'package:flutter_challenge/risk_reward_graph/model/option_analysis_result.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/services/options_calculator.dart';
import 'package:get/get.dart';

class OptionsCalculatorScreenController extends GetxController {
  List<OptionContractModel> options;
  OptionsCalculatorScreenController(this.options);

  late final OptionsAnalysisResult result;
  @override
  onInit() {
    super.onInit();
    result = OptionsCalculatorService.calculateProfitLoss(options);
  }

  ///getter of the strings for the UI
  String get maxProfitStr => "\$${result.maxProfit.toStringAsFixed(2)}";
  String get maxLossStr => "\$${result.maxLoss.toStringAsFixed(2)}";
  String get breakEvenPointsStr =>
      result.breakEvenPoints.map((e) => e.toStringAsFixed(2)).join(", ");
}
