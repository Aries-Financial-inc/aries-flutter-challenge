import 'package:flutter_challenge/constants/enums.dart';

class OptionData {
  final double strikePrice;
  final OptionTypes type; // "Call" or "Put"
  final double bid;
  final double ask;
  final LongShort longShort; // "long" or "short"
  final DateTime expirationDate;

  OptionData({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  double calculateProfit(double underlyingPriceAtExpiration) {
    double premium = longShort == LongShort.long ? ask : bid;
    double intrinsicValue = 0;
    if (type == OptionTypes.call) {
      intrinsicValue = underlyingPriceAtExpiration > strikePrice
          ? underlyingPriceAtExpiration - strikePrice
          : 0;
    } else if (type == OptionTypes.put) {
      intrinsicValue = underlyingPriceAtExpiration < strikePrice
          ? strikePrice - underlyingPriceAtExpiration
          : 0;
    }

    double profitLoss = 0;
    if (longShort == LongShort.long) {
      profitLoss = intrinsicValue - premium;
    } else if (longShort == LongShort.short) {
      profitLoss = premium - intrinsicValue;
    }

    return profitLoss;
  }

  static double calculateMinY(List<OptionData> optionDataList) {
    double min = double.infinity;
    for (OptionData data in optionDataList) {
      double profitLoss = data.calculateProfit(data.strikePrice);
      if (profitLoss < min) {
        min = profitLoss;
      }
    }
    return min;
  }

  static double calculateMaxY(List<OptionData> optionDataList) {
    double max = double.negativeInfinity;
    for (OptionData data in optionDataList) {
      double profitLoss = data.calculateProfit(data.strikePrice);
      if (profitLoss > max) {
        max = profitLoss;
      }
    }
    return max;
  }

  static double calculateBreakEvenPoint(List<OptionData> optionDataList) {
    if (optionDataList.isNotEmpty) {
      double strikePrice = optionDataList.first.strikePrice;
      double premium = optionDataList.first.longShort == LongShort.long
          ? optionDataList.first.ask
          : optionDataList.first.bid;
      return strikePrice + premium;
    }
    return 0;
  }
}
