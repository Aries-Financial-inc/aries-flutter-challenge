import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_point_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_result_model.dart';
import 'package:flutter_challenge/services/options_service.dart';

import '../models/option_model.dart';

class RiskAndRewardRepository {
  final OptionService optionService = OptionService();
  // Calculate profit/loss points
  ProfitLossResult calculateProfitLoss(
    List<OptionModel> options,
    double minPrice,
    double maxPrice,
    double step,
  ) {
    return optionService.calculateProfitLoss(options, minPrice, maxPrice, step);
  }
}
