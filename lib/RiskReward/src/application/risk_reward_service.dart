import '../domain/option_data.dart';
import '../domain/payoff_data.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class RiskRewardService {
  double minUnderlyingPrice(List<OptionData> optionsData) {
    double minStrike = optionsData
        .map((option) => option.strikePrice)
        .reduce((a, b) => a < b ? a : b);
    return minStrike * 0.5; // Adding 30% buffer below the min strike price
  }

  double maxUnderlyingPrice(List<OptionData> optionsData) {
    double maxStrike = optionsData
        .map((option) => option.strikePrice)
        .reduce((a, b) => a > b ? a : b);
    return maxStrike * 1.5; // Adding 30% buffer above the max strike price
  }

  double maxProfit(List<PayoffData> payoffs) =>
      payoffs.map((data) => data.payoff).reduce((a, b) => a > b ? a : b);
  double maxLoss(List<PayoffData> payoffs) =>
      payoffs.map((data) => data.payoff).reduce((a, b) => a < b ? a : b);

  List<double> calculateBreakEvenPoints(List<PayoffData> combinedPayoff) {
    List<double> breakEvenPoints = [];

    for (int i = 0; i < combinedPayoff.length - 1; i++) {
      double currentPayoff = combinedPayoff[i].payoff;
      double nextPayoff = combinedPayoff[i + 1].payoff;

      // Check if there's a sign change between current and next payoff
      if ((currentPayoff > 0 && nextPayoff < 0) ||
          (currentPayoff < 0 && nextPayoff > 0)) {
        // Linearly interpolate to find the exact break-even point
        double underlyingPrice1 = combinedPayoff[i].underlyingPrice;
        double underlyingPrice2 = combinedPayoff[i + 1].underlyingPrice;
        double breakEvenPrice = underlyingPrice1 -
            currentPayoff *
                (underlyingPrice2 - underlyingPrice1) /
                (nextPayoff - currentPayoff);
        breakEvenPoints.add(breakEvenPrice);
      }
    }

    return breakEvenPoints;
  }

  /// Calculates the payoff for a given option over a range of underlying prices.
  ///
  /// [option] The option data which includes type, strike price, bid, ask, and position.
  /// [underlyingPrices] A list of underlying prices to calculate the payoff for.
  /// Returns a list of [PayoffData] containing the underlying prices and their corresponding payoffs.
  List<PayoffData> calculatePayoff(
      OptionData option, List<double> underlyingPrices) {
    List<PayoffData> payoffs = [];

    for (double underlyingPrice in underlyingPrices) {
      double payoff = 0.0;
      if (option.type == 'Call') {
        if (option.longShort == 'long') {
          payoff =
              (underlyingPrice - option.strikePrice).clamp(0, double.infinity) -
                  option.ask;
        } else if (option.longShort == 'short') {
          payoff = option.bid -
              (underlyingPrice - option.strikePrice).clamp(0, double.infinity);
        }
      } else if (option.type == 'Put') {
        if (option.longShort == 'long') {
          payoff =
              (option.strikePrice - underlyingPrice).clamp(0, double.infinity) -
                  option.ask;
        } else if (option.longShort == 'short') {
          payoff = option.bid -
              (option.strikePrice - underlyingPrice).clamp(0, double.infinity);
        }
      }
      // Ensure long positions do not go negative
      if (option.longShort == 'long' && payoff < -option.ask) {
        payoff = -option.ask;
      }
      // Ensure short positions do not go below zero
      if (option.longShort == 'short' && payoff < 0) {
        payoff = 0;
      }
      payoffs.add(PayoffData(underlyingPrice, payoff));
    }

    return payoffs;
  }

  /// Calculates the combined payoffs for a list of options over a range of underlying prices.
  ///
  /// [optionsData] A list of option data which includes type, strike price, bid, ask, and position.
  /// [minUnderlyingPrice] The minimum underlying price to consider.
  /// [maxUnderlyingPrice] The maximum underlying price to consider.
  /// Returns a list of [PayoffData] containing the underlying prices and their corresponding combined payoffs.
  List<PayoffData> calculateCombinedPayoffs(List<OptionData> optionsData,
      double minUnderlyingPrice, double maxUnderlyingPrice) {
    final underlyingPrices = List.generate(
        500,
        (index) =>
            minUnderlyingPrice +
            index * (maxUnderlyingPrice - minUnderlyingPrice) / 499);

    List<PayoffData> combinedPayoff = [];

    for (var price in underlyingPrices) {
      double totalPayoff = 0.0;

      for (var option in optionsData) {
        final payoffs = calculatePayoff(option, [price]);
        totalPayoff += payoffs.first.payoff;
      }

      print('Price: $price, Total Payoff: $totalPayoff');
      combinedPayoff.add(PayoffData(price, totalPayoff));
    }

    return combinedPayoff;
  }

  List<charts.Series<PayoffData, double>> mapOptionData(
      List<OptionData> optionsData, List<PayoffData> payoffs) {
    // Create series for combined payoff
    var seriesList = [
      charts.Series<PayoffData, double>(
        id: 'Combined Payoff',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (PayoffData data, _) => data.underlyingPrice,
        measureFn: (PayoffData data, _) => data.payoff,
        data: payoffs,
      ),
    ];

    // Add individual payoffs for reference with colors based on type and long/short
    for (var option in optionsData) {
      var color = getColorBasedOnTypeAndPosition(option);
      seriesList.add(
        charts.Series<PayoffData, double>(
          id: '${option.type} ${option.strikePrice} (${option.longShort})',
          colorFn: (_, __) => color,
          domainFn: (PayoffData data, _) => data.underlyingPrice,
          measureFn: (PayoffData data, _) => data.payoff,
          data: calculatePayoff(
              option, payoffs.map((e) => e.underlyingPrice).toList()),
          //dashPattern: [4, 4],
        ),
      );
    }

    return seriesList;
  }

  charts.Color getColorBasedOnTypeAndPosition(OptionData option) {
    if (option.type == 'Call') {
      return option.longShort == 'long'
          ? charts.MaterialPalette.green.shadeDefault
          : charts.MaterialPalette.green.shadeDefault.lighter;
    } else {
      return option.longShort == 'long'
          ? charts.MaterialPalette.red.shadeDefault
          : charts.MaterialPalette.red.shadeDefault.lighter;
    }
  }
}
