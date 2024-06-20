import '../utils/option_calculator.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/option_contract.dart';

/// Repository responsible for calculating options strategy metrics.
class OptionsStrategyRepository {
  List<FlSpot> generateGraphData(List<OptionContract> contracts) {
    return OptionCalculator.calculateGraphPoints(contracts);
  }

  double calculateMaxProfit(List<OptionContract> contracts) {
    return OptionCalculator.getMaxProfit(contracts);
  }

  double calculateMaxLoss(List<OptionContract> contracts) {
    return OptionCalculator.getMaxLoss(contracts);
  }

  List<double> calculateBreakEvenPoints(List<OptionContract> contracts) {
    return OptionCalculator.getBreakEvenPoints(contracts);
  }
}
