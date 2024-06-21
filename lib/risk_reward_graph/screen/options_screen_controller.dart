import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/services/options_calculator.dart';
import 'package:get/get.dart';

class OptionsCalculatorScreenController extends GetxController {
  List<OptionContractModel> options;
  OptionsCalculatorScreenController(this.options);

  List<MapEntry<double, double>> profitLossData = [];
  double maxProfit = 0.0;
  double maxLoss = 0.0;
  List<double> breakEvenPoints = [];

  @override
  onInit() {
    super.onInit();
    initialise();
  }

  initialise() {
    final result = OptionsCalculatorService.calculateProfitLoss(options);
    profitLossData = result['profitLossData'];
    maxProfit = result['maxProfit'];
    maxLoss = result['maxLoss'];
    breakEvenPoints = result['breakEvenPoints'];
  }

  ///getter of the strings for the UI
  String get maxProfitStr => "\$${maxProfit.toStringAsFixed(2)}";
  String get maxLossStr => "\$${maxLoss.toStringAsFixed(2)}";
  String get breakEvenPointsStr =>
      breakEvenPoints.map((e) => e.toStringAsFixed(2)).join(", ");
}
