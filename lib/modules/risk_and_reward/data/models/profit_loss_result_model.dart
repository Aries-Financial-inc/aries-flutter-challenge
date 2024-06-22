import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_point_model.dart';

class ProfitLossResult {
  final List<ProfitLossPoint> profitLossData;
  final double maxProfit;
  final double maxLoss;
  final List<double> breakEvenPoints;

  ProfitLossResult({
    required this.profitLossData,
    required this.maxProfit,
    required this.maxLoss,
    required this.breakEvenPoints,
  });

  @override
  String toString() {
    return 'ProfitLossResult(profitLossData: $profitLossData, maxProfit: $maxProfit, maxLoss: $maxLoss, breakEvenPoints: $breakEvenPoints)';
  }
}