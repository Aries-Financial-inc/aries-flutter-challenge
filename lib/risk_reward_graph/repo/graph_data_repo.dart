import 'package:flutter_challenge/risk_reward_graph/model/option_analysis_result.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/services/options_calculator.dart';

abstract class GraphDataRepo {
  OptionsAnalysisResult getData(List<OptionContractModel> options);
}

class GraphDataRepoImpl implements GraphDataRepo {
  @override
  OptionsAnalysisResult getData(List<OptionContractModel> options) {
    return OptionsCalculatorService.calculateProfitLoss(options);
  }
}
