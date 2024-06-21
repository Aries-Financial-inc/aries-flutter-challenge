import 'package:flutter_challenge/risk_reward_graph/model/option_analysis_result.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/repo/graph_data_repo.dart';
import 'package:flutter_challenge/risk_reward_graph/services/options_calculator.dart';
import 'package:get/get.dart';

class OptionsCalculatorScreenController extends GetxController {
  final GraphDataRepo _repo = GraphDataRepoImpl();
  List<OptionContractModel> options;
  OptionsCalculatorScreenController(this.options);

  late final OptionsAnalysisResult result;
  @override
  onInit() {
    super.onInit();
    result = _repo.getData(options);
  }

  ///getter of the strings for the UI
  String get maxProfitStr => "\$${result.maxProfit.toStringAsFixed(2)}";
  String get maxLossStr => "\$${result.maxLoss.toStringAsFixed(2)}";
  String get breakEvenPointsStr =>
      result.breakEvenPoints.map((e) => e.toStringAsFixed(2)).join(", ");
}
