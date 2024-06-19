import '../domain/option_data.dart';
import '../domain/payoff_data.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class RiskRewardService {
  double minUnderlyingPrice(List optionsData) => optionsData
      .map((option) => option.strikePrice)
      .reduce((a, b) => a < b ? a : b);

  double maxUnderlyingPrice(List optionsData) => optionsData
      .map((option) => option.strikePrice)
      .reduce((a, b) => a > b ? a : b);

  double maxProfit(List<PayoffData> payoffs) =>
      payoffs.map((data) => data.payoff).reduce((a, b) => a > b ? a : b);
  double maxLoss(List<PayoffData> payoffs) =>
      payoffs.map((data) => data.payoff).reduce((a, b) => a < b ? a : b);

  List<double> calculateBreakEvenPoints(List<PayoffData> payoffs) {
    print('Payoffs: $payoffs');
    List<double> breakEvenPoints = [];
    for (int i = 0; i < payoffs.length - 1; i++) {
      if (payoffs[i].payoff == 0) {
        breakEvenPoints.add(payoffs[i].underlyingPrice);
      } else if (payoffs[i].payoff * payoffs[i + 1].payoff < 0) {
        double x1 = payoffs[i].underlyingPrice;
        double y1 = payoffs[i].payoff;
        double x2 = payoffs[i + 1].underlyingPrice;
        double y2 = payoffs[i + 1].payoff;
        double breakEvenPoint = x1 - y1 * (x2 - x1) / (y2 - y1);
        breakEvenPoints.add(breakEvenPoint);
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
    List<PayoffData> payoffData = [];

    for (var price in underlyingPrices) {
      double payoff;

      if (option.longShort == 'long') {
        double premium = option.ask;

        if (option.type == 'Call') {
          payoff = price <= option.strikePrice
              ? -premium
              : price - option.strikePrice - premium;
        } else {
          // Put
          payoff = price >= option.strikePrice
              ? -premium
              : option.strikePrice - price - premium;
        }
      } else {
        // short position
        double premium = option.bid;

        if (option.type == 'Call') {
          payoff = price <= option.strikePrice
              ? premium
              : premium - (price - option.strikePrice);
        } else {
          // Put
          payoff = price >= option.strikePrice
              ? premium
              : premium - (option.strikePrice - price);
        }
      }

      payoffData.add(PayoffData(price, payoff));
    }

    return payoffData;
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
