import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter_challenge/RiskReward/src/application/risk_reward_service.dart';
import 'package:flutter_challenge/RiskReward/src/domain/option_data.dart';

class RiskRewardChart extends StatelessWidget {
  final List<OptionData> optionsData;
  final RiskRewardService riskRewardService;

  RiskRewardChart({
    super.key,
    this.optionsData = const [],
    RiskRewardService? riskRewardServiceInstance,
  }) : riskRewardService = riskRewardServiceInstance ?? RiskRewardService();

  @override
  Widget build(BuildContext context) {
    return optionsData.isEmpty
        ? const Center(
            child: Text('No options data'),
          )
        : charts.LineChart(riskRewardService.mapOptionData(optionsData),
            behaviors: [
              charts.SeriesLegend(
                position: charts.BehaviorPosition.bottom,
                outsideJustification:
                    charts.OutsideJustification.middleDrawArea,
                horizontalFirst: false,
                desiredMaxRows: 2,
                cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                entryTextStyle: charts.TextStyleSpec(
                  color: charts.MaterialPalette.black,
                  fontFamily: 'Georgia',
                  fontSize: 11,
                ),
              ),
              charts.ChartTitle('Underlying Asset Price',
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea),
              charts.ChartTitle('Profit / Loss',
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification:
                      charts.OutsideJustification.middleDrawArea),
              charts.RangeAnnotation(
                  riskRewardService.createAnnotations(optionsData)),
            ],
            defaultRenderer: charts.LineRendererConfig(includePoints: true),
            domainAxis: charts.NumericAxisSpec(
              viewport: charts.NumericExtents(
                riskRewardService.minUnderlyingPrice(optionsData) - 10,
                riskRewardService.maxUnderlyingPrice(optionsData) + 10,
              ),
              tickProviderSpec:
                  const charts.BasicNumericTickProviderSpec(zeroBound: false),
            ),
            animate: true);
  }
}
