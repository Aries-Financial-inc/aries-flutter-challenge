import '../domain/option_data.dart';
import '../domain/payoff_data.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class RiskRewardService {
  PayoffData calculatePayoff(OptionData option) {
    double payoff;
    double underlyingPrice = option.strikePrice;

    if (option.longShort == 'long') {
      double premium = option.ask;
      if (option.type == 'Call') {
        payoff = (underlyingPrice > option.strikePrice
                ? underlyingPrice - option.strikePrice
                : 0) -
            premium;
      } else {
        payoff = (underlyingPrice < option.strikePrice
                ? option.strikePrice - underlyingPrice
                : 0) -
            premium;
      }
    } else {
      double premium = option.bid;
      if (option.type == 'Call') {
        payoff = premium -
            (underlyingPrice > option.strikePrice
                ? underlyingPrice - option.strikePrice
                : 0);
      } else {
        payoff = premium -
            (underlyingPrice < option.strikePrice
                ? option.strikePrice - underlyingPrice
                : 0);
      }
    }

    return PayoffData(underlyingPrice, payoff);
  }

  List<charts.Series<PayoffData, double>> mapOptionData(
      List<OptionData> optionsData) {
    // Calculate payoffs for each option
    List<PayoffData> combinedPayoff = [];
    List<charts.Series<PayoffData, double>> seriesList = [];

    for (var option in optionsData) {
      final payoff = calculatePayoff(option);
      combinedPayoff.add(payoff);

      seriesList.add(
        charts.Series<PayoffData, double>(
          id: '${option.type} ${option.strikePrice} (${option.longShort})',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.lighter,
          domainFn: (PayoffData data, _) => data.underlyingPrice,
          measureFn: (PayoffData data, _) => data.payoff,
          data: [payoff],
          //dashPattern: [4, 4],
        ),
      );
    }

    // Calculate the combined payoff
    double totalPayoff =
        combinedPayoff.map((data) => data.payoff).reduce((a, b) => a + b);
    double averageUnderlyingPrice = combinedPayoff
            .map((data) => data.underlyingPrice)
            .reduce((a, b) => a + b) /
        combinedPayoff.length;

    seriesList.add(
      charts.Series<PayoffData, double>(
        id: 'Combined Payoff',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (PayoffData data, _) => data.underlyingPrice,
        measureFn: (PayoffData data, _) => data.payoff,
        data: [PayoffData(averageUnderlyingPrice, totalPayoff)],
      ),
    );

    return seriesList;
  }
}
