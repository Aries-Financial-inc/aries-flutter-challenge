import 'package:flutter_challenge/data_models/data_models.dart';

class OptionCalculator {
  List<Map<String, double>> calculateTotalProfitLoss(
      List<OptionContract> options,
      double minPrice,
      double maxPrice,
      double step) {
    List<Map<String, double>> results = [];
    for (double underlyingPrice = minPrice;
        underlyingPrice <= maxPrice;
        underlyingPrice += step) {
      double totalProfitLoss = 0;
      for (var option in options) {
        totalProfitLoss += option.calculatePayoff(underlyingPrice);
      }
      results.add({
        "underlyingPrice": underlyingPrice,
        "profitLoss": totalProfitLoss,
      });
    }
    return results;
  }

  Map<String, double> findMaxMinProfitLoss(
      List<Map<String, double>> profitLossData) {
    double maxProfit = double.negativeInfinity;
    double maxLoss = double.infinity;
    for (var data in profitLossData) {
      if (data['profitLoss']! > maxProfit) {
        maxProfit = data['profitLoss']!;
      }
      if (data['profitLoss']! < maxLoss) {
        maxLoss = data['profitLoss']!;
      }
    }
    return {"maxProfit": maxProfit, "maxLoss": maxLoss};
  }

  List<double> findBreakEvenPoints(List<Map<String, double>> profitLossData) {
    List<double> breakEvenPoints = [];
    for (int i = 1; i < profitLossData.length; i++) {
      if ((profitLossData[i - 1]['profitLoss']! > 0 &&
              profitLossData[i]['profitLoss']! < 0) ||
          (profitLossData[i - 1]['profitLoss']! < 0 &&
              profitLossData[i]['profitLoss']! > 0)) {
        double breakEvenPoint = (profitLossData[i - 1]['underlyingPrice']! +
                profitLossData[i]['underlyingPrice']!) /
            2;
        breakEvenPoints.add(breakEvenPoint);
      }
    }
    return breakEvenPoints;
  }

  List<ProfitLossData> prepareChartData(
    List<Map<String, double>> profitLossData,
  ) {
    return profitLossData.map((data) {
      return ProfitLossData.fromJson(data);
    }).toList();
  }
}
