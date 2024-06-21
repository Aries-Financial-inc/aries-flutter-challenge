class OptionsAnalysisResult {
  final List<MapEntry<double, double>> profitLossData;
  final double maxProfit;
  final double maxLoss;
  final List<double> breakEvenPoints;

  OptionsAnalysisResult({
    required this.profitLossData,
    required this.maxProfit,
    required this.maxLoss,
    required this.breakEvenPoints,
  });
}
