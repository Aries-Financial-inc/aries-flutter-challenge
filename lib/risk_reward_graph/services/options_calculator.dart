import 'dart:math';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';

class OptionsCalculatorService {
  static double calculateOptionProfitLoss(
      OptionContract option, double underlyingPrice) {
    final strikePrice = option.strikePrice;
    final type = option.type;
    final isLong = option.longShort == 'long';
    final priceDifference = underlyingPrice - strikePrice;

    double intrinsicValue = 0;
    if (type == 'Call') {
      intrinsicValue = max(priceDifference, 0);
    } else if (type == 'Put') {
      intrinsicValue = max(strikePrice - underlyingPrice, 0);
    }

    final cost = (option.bid + option.ask) / 2;

    if (isLong) {
      return intrinsicValue - cost;
    } else {
      return cost - intrinsicValue;
    }
  }

  static Map<String, dynamic> calculateProfitLoss(
      List<OptionContract> optionsData) {
    final underlyingPrices = List.generate(50, (index) => 80.0 + index);
    List<double> profitLoss = [];
    double maxProfit = double.negativeInfinity;
    double maxLoss = double.infinity;
    List<double> breakEvenPoints = [];

    for (var price in underlyingPrices) {
      double totalProfitLoss = 0;
      for (var option in optionsData) {
        totalProfitLoss += calculateOptionProfitLoss(option, price);
      }
      profitLoss.add(totalProfitLoss);
      if (totalProfitLoss > maxProfit) maxProfit = totalProfitLoss;
      if (totalProfitLoss < maxLoss) maxLoss = totalProfitLoss;
      if (price > 50 &&
          profitLoss.length > 1 &&
          totalProfitLoss.sign != profitLoss[profitLoss.length - 2].sign) {
        breakEvenPoints.add(price);
      }
    }

    return {
      'profitLossData': underlyingPrices
          .asMap()
          .entries
          .map((entry) => MapEntry(entry.value, profitLoss[entry.key]))
          .toList(),
      'maxProfit': maxProfit,
      'maxLoss': maxLoss,
      'breakEvenPoints': breakEvenPoints,
    };
  }
}
