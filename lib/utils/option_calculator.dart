import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import '../models/option_contract.dart';

class OptionCalculator {
  /// Generates profit/loss graph data for the given list of option contracts.
  static List<FlSpot> calculateGraphPoints(List<OptionContract> options) {
    List<FlSpot> points = [];
    for (double price = 80; price <= 120; price += 0.5) {
      double profit = 0;
      for (var option in options) {
        // Calculate profit/loss for call options.
        if (option.type == OptionType.call) {
          double intrinsicValue = max(price - option.strikePrice, 0);
          profit +=
              (option.longShort == LongShort.long ? 1 : -1) * intrinsicValue;
        }
        // Calculate profit/loss for call options.
        else if (option.type == OptionType.put) {
          double intrinsicValue = max(option.strikePrice - price, 0);
          profit +=
              (option.longShort == LongShort.long ? 1 : -1) * intrinsicValue;
        }
      }
      points.add(FlSpot(price, profit));
    }
    return points;
  }

  /// Calculate profit for the given list of option contracts.
  static double calculateProfit(
      List<OptionContract> options, double underlyingPrice) {
    double profit = 0;
    for (var option in options) {
      if (option.type == OptionType.call) {
        double intrinsicValue = max(underlyingPrice - option.strikePrice, 0);
        profit +=
            (option.longShort == LongShort.long ? 1 : -1) * intrinsicValue -
                option.ask;
      } else if (option.type == OptionType.put) {
        double intrinsicValue = max(option.strikePrice - underlyingPrice, 0);
        profit +=
            (option.longShort == LongShort.long ? 1 : -1) * intrinsicValue -
                option.ask;
      }
    }
    return profit;
  }

  /// Calculate max profit for the given list of option contracts.
  static double getMaxProfit(List<OptionContract> options) {
    return options.map((option) {
      if (option.type == OptionType.call &&
          option.longShort == LongShort.long) {
        return double.infinity;
      } else if (option.type == OptionType.put &&
          option.longShort == LongShort.long) {
        return option.strikePrice - option.ask;
      } else if (option.type == OptionType.call &&
          option.longShort == LongShort.short) {
        return option.ask;
      } else if (option.type == OptionType.put &&
          option.longShort == LongShort.short) {
        return option.ask;
      }
      return 0.0;
    }).reduce(max);
  }

  /// Calculate max loss for the given list of option contracts.
  static double getMaxLoss(List<OptionContract> options) {
    return options.map((option) {
      if (option.type == OptionType.call &&
          option.longShort == LongShort.long) {
        return -option.ask;
      } else if (option.type == OptionType.put &&
          option.longShort == LongShort.long) {
        return -option.ask;
      } else if (option.type == OptionType.call &&
          option.longShort == LongShort.short) {
        return -double.infinity;
      } else if (option.type == OptionType.put &&
          option.longShort == LongShort.short) {
        return option.strikePrice - option.ask;
      }
      return 0.0;
    }).reduce(min);
  }

  /// Get the break even points for the given list of option contracts.
  static List<double> getBreakEvenPoints(List<OptionContract> options) {
    Set<double> breakEvenPoints = {};
    for (var option in options) {
      if (option.type == OptionType.call) {
        breakEvenPoints.add(option.strikePrice + option.ask);
      } else if (option.type == OptionType.put) {
        breakEvenPoints.add(option.strikePrice - option.ask);
      }
    }
    return breakEvenPoints.toList()..sort();
  }

  /// parser function used to generate OptionContractDTO form the challenge json data .
  static List<OptionContractDTO> parseOptionContractsFromJson(
      List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => OptionContractDTO.fromJson(json)).toList();
  }
}
