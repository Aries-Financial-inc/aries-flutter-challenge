import 'dart:math';

import 'package:flutter_challenge/modules/risk_and_reward/data/models/option_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_point_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_result_model.dart';

class OptionService {
  ProfitLossResult calculateProfitLoss(
    List<OptionModel> options,
    double minPrice,
    double maxPrice,
    double step,
  ) {
    List<ProfitLossPoint> profitLossData = [];
    double maxProfit = double.negativeInfinity;
    double maxLoss = double.infinity;
    List<double> breakEvenPoints = [];

    for (double underlyingPrice = minPrice;
        underlyingPrice <= maxPrice;
        underlyingPrice += step) {
      double totalProfitLoss = 0;
      for (var option in options) {
        totalProfitLoss += _calculatePayoff(option, underlyingPrice);
      }

      profitLossData.add(ProfitLossPoint(underlyingPrice, totalProfitLoss));

      if (totalProfitLoss > maxProfit) {
        maxProfit = totalProfitLoss;
      }

      if (totalProfitLoss < maxLoss) {
        maxLoss = totalProfitLoss;
      }

      if ((profitLossData.length > 1 &&
              (profitLossData[profitLossData.length - 2].profitLoss > 0 &&
                  totalProfitLoss <= 0)) ||
          (profitLossData.length > 1 &&
              (profitLossData[profitLossData.length - 2].profitLoss < 0 &&
                  totalProfitLoss >= 0))) {
        double breakEvenPoint =
            (profitLossData[profitLossData.length - 2].underlyingPrice +
                    underlyingPrice) /
                2;
        breakEvenPoints.add(breakEvenPoint);
      }
    }

    return ProfitLossResult(
      profitLossData: profitLossData,
      maxProfit: maxProfit,
      maxLoss: maxLoss,
      breakEvenPoints: breakEvenPoints,
    );
  }

  double _calculatePayoff(OptionModel option, double underlyingPrice) {
    double premium = option.longShort == 'long' ? option.ask : option.bid;

    if (option.type == 'Call') {
      if (option.longShort == 'long') {
        return (underlyingPrice - option.strikePrice)
                .clamp(0, double.infinity) -
            premium;
      } else {
        return premium -
            (underlyingPrice - option.strikePrice).clamp(0, double.infinity);
      }
    } else {
      // option.type == 'Put'
      if (option.longShort == 'long') {
        return (option.strikePrice - underlyingPrice)
                .clamp(0, double.infinity) -
            premium;
      } else {
        return premium -
            (option.strikePrice - underlyingPrice).clamp(0, double.infinity);
      }
    }
  }
}
