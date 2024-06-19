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

  List<PayoffData> calculatePayoff(
      OptionData option, List<double> underlyingPrices) {
    List<PayoffData> payoffData = [];
    for (var price in underlyingPrices) {
      double payoff;
      if (option.longShort == 'long') {
        double premium = option.ask;
        if (option.type == 'Call') {
          payoff =
              (price > option.strikePrice ? price - option.strikePrice : 0) -
                  premium;
        } else {
          // Put
          payoff =
              (price < option.strikePrice ? option.strikePrice - price : 0) -
                  premium;
        }
      } else {
        // short position
        double premium = option.bid;
        if (option.type == 'Call') {
          payoff = premium -
              (price > option.strikePrice ? price - option.strikePrice : 0);
        } else {
          // Put
          payoff = premium -
              (price < option.strikePrice ? option.strikePrice - price : 0);
        }
      }
      payoffData.add(PayoffData(price, payoff));
    }
    return payoffData;
  }

  List<charts.Series<PayoffData, double>> mapOptionData(
      List<OptionData> optionsData) {
    // Define a range of underlying asset prices
    final underlyingPrices =
        List.generate(500, (index) => 90 + index * (120 - 90) / 499);

    // Calculate payoffs for each option
    List<List<PayoffData>> payoffs = [];
    for (var option in optionsData) {
      payoffs.add(calculatePayoff(option, underlyingPrices));
    }

    // Calculate combined payoff
    List<PayoffData> combinedPayoff = [];
    for (int i = 0; i < underlyingPrices.length; i++) {
      double totalPayoff =
          payoffs.map((payoff) => payoff[i].payoff).reduce((a, b) => a + b);
      combinedPayoff.add(PayoffData(underlyingPrices[i], totalPayoff));
    }

    // Create series for combined payoff
    var seriesList = [
      charts.Series<PayoffData, double>(
        id: 'Combined Payoff',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (PayoffData data, _) => data.underlyingPrice,
        measureFn: (PayoffData data, _) => data.payoff,
        data: combinedPayoff,
      ),
    ];

    // Add individual payoffs for reference
    for (var i = 0; i < optionsData.length; i++) {
      var color = getColorBasedOnTypeAndPosition(optionsData[i]);
      seriesList.add(
        charts.Series<PayoffData, double>(
          id: '${optionsData[i].type} ${optionsData[i].strikePrice} (${optionsData[i].longShort})',
          colorFn: (_, __) => color,
          domainFn: (PayoffData data, _) => data.underlyingPrice,
          measureFn: (PayoffData data, _) => data.payoff,
          data: payoffs[i],
          //  dashPattern: [4, 4],
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
