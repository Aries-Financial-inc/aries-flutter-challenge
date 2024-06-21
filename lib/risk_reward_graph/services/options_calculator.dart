import 'dart:math';
import 'package:flutter_challenge/risk_reward_graph/model/option_analysis_result.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';

///Business level implementation of option calc
class OptionsCalculatorService {
  /// Calculates the overall profit or loss for a list of option contracts
  /// across a range of underlying prices, and finds all break-even points.
  static OptionsAnalysisResult calculateProfitLoss(
      List<OptionContractModel> optionsData) {
    // Define the range of underlying prices to evaluate

    final List<double> underlyingPrices = _computeRange(optionsData);

    List<double> profitLoss = [];
    double maxProfit = double.negativeInfinity;
    double maxLoss = double.infinity;

    // Set to store unique break-even points
    Set<double> breakEvenPointsSet = {};

    // Calculate profit or loss for each underlying price
    for (double price in underlyingPrices) {
      double totalProfitLoss = 0;

      // Sum the profit or loss for each option at this underlying price
      for (OptionContractModel option in optionsData) {
        totalProfitLoss += _calculateOptionProfitLoss(option, price);
      }
      profitLoss.add(totalProfitLoss);

      // Update max profit and max loss
      if (totalProfitLoss > maxProfit) {
        maxProfit = totalProfitLoss;
      }
      if (totalProfitLoss < maxLoss) {
        maxLoss = totalProfitLoss;
      }

      // Identify break-even points for each individual option contract
      for (var option in optionsData) {
        List<double> individualBreakEvenPoints =
            _calculateIndividualBreakEvenPoints(option);
        breakEvenPointsSet.addAll(individualBreakEvenPoints);
      }
    }

    // Convert break-even points set to a sorted list
    List<double> breakEvenPoints = breakEvenPointsSet.toList()..sort();

    // Convert profit/loss data to a list of MapEntry for compatibility
    List<MapEntry<double, double>> profitLossData = [];
    for (int i = 0; i < underlyingPrices.length; i++) {
      profitLossData.add(MapEntry(underlyingPrices[i], profitLoss[i]));
    }
    return OptionsAnalysisResult(
        profitLossData: profitLossData,
        maxProfit: maxProfit,
        maxLoss: maxLoss,
        breakEvenPoints: breakEvenPoints);
  }

  /// Calculates the profit or loss for a given option contract
  /// based on the underlying price.
  static double _calculateOptionProfitLoss(
      OptionContractModel option, double underlyingPrice) {
    final strikePrice = option.strikePrice;
    final isLong = option.isLong;
    final priceDifference = underlyingPrice - strikePrice;

    // Determine intrinsic value
    double intrinsicValue = 0;
    if (option.isCall) {
      intrinsicValue = max(priceDifference, 0);
    } else {
      intrinsicValue = max(strikePrice - underlyingPrice, 0);
    }

    // Calculate cost of the option
    final cost = (option.bid + option.ask) / 2;

    // Compute profit or loss based on whether the position is long or short
    if (isLong) {
      return intrinsicValue - cost;
    } else {
      return cost - intrinsicValue;
    }
  }

  ///computes the range of a graph to draw
  static List<double> _computeRange(List<OptionContractModel> optionsData) {
    if (optionsData.isEmpty) {
      return List<double>.generate(50, (index) => 80.0 + index);
    }
    final price = optionsData.first.strikePrice;
    const double spread = 20;
    double start = price - (spread / 2).floor();
    double end = price + spread;
    // Generate the list of numbers
    List<double> result = [];
    for (double i = start; i <= end; i++) {
      result.add(i);
    }

    return result;
  }

  /// Calculates the break-even points for a single option contract.
  static List<double> _calculateIndividualBreakEvenPoints(
      OptionContractModel option) {
    List<double> breakEvenPoints = [];

    // Calculate the cost of the option
    final cost = (option.bid + option.ask) / 2;

    if (option.isCall) {
      if (option.isLong) {
        // Break-even point for a long call
        breakEvenPoints.add(option.strikePrice + cost);
      } else {
        // Break-even point for a short call
        breakEvenPoints.add(option.strikePrice - cost);
      }
    } else {
      if (option.isLong) {
        // Break-even point for a long put
        breakEvenPoints.add(option.strikePrice - cost);
      } else {
        // Break-even point for a short put
        breakEvenPoints.add(option.strikePrice + cost);
      }
    }

    return breakEvenPoints;
  }
}
