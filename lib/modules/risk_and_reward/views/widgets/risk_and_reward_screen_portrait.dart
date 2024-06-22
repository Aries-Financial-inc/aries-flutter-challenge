import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_point_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/domain/controllers/risk_and_reward_controller.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/risk_and_reward_state_model.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:get/get.dart';

class RiskAndRewardScreenPortrait extends StatelessWidget {
  final RiskAndRewardController _controller =
      Get.find<RiskAndRewardController>();

  RiskAndRewardScreenPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiskAndRewardController, RiskAndRewardState>(
      bloc: _controller,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Risk and Reward Portrait'),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : buildChartWidget(),
        );
      },
    );
  }

  Widget buildChartWidget() {
    final state = _controller.state;

    final data = state.spots.map((spot) => ProfitLossPoint(spot.x, spot.y)).toList();

    List<charts.Series<ProfitLossPoint, double>> series = [
      charts.Series<ProfitLossPoint, double>(
        id: 'RiskAndReward',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ProfitLossPoint point, _) => point.underlyingPrice,
        measureFn: (ProfitLossPoint point, _) => point.profitLoss,
        data: data,
      ),
    ];

    // Add series for break-even points
    for (var breakEvenPoint in state.breakEvenPoints) {
      series.add(
        charts.Series<ProfitLossPoint, double>(
          id: 'BreakEven-$breakEvenPoint',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (ProfitLossPoint point, _) => point.underlyingPrice,
          measureFn: (ProfitLossPoint point, _) => point.profitLoss,
          data: [
            ProfitLossPoint(breakEvenPoint, state.minY),
            ProfitLossPoint(breakEvenPoint, state.maxY),
          ],
          dashPatternFn: (_, __) => [4, 4], // Dotted line pattern
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: charts.LineChart(
              series,
              animate: true,
              domainAxis: charts.NumericAxisSpec(
                viewport: charts.NumericExtents(state.minX, state.maxX),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                viewport: charts.NumericExtents(state.minY, state.maxY),
              ),
              behaviors: [
                charts.ChartTitle('Underlying Price',
                    behaviorPosition: charts.BehaviorPosition.bottom,
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea),
                charts.ChartTitle('Profit / Loss',
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea),
                charts.RangeAnnotation(
                  state.breakEvenPoints.map((point) {
                    return charts.LineAnnotationSegment(
                      point,
                      charts.RangeAnnotationAxisType.domain,
                      startLabel: 'Break-even',
                      labelAnchor: charts.AnnotationLabelAnchor.end,
                      color: charts.MaterialPalette.red.shadeDefault,
                      dashPattern: [4, 4],
                    );
                  }).toList(),
                ),
                charts.RangeAnnotation([
                  charts.LineAnnotationSegment(
                    state.maxProfit,
                    charts.RangeAnnotationAxisType.measure,
                    startLabel: 'Max Profit',
                    labelAnchor: charts.AnnotationLabelAnchor.end,
                    color: charts.MaterialPalette.green.shadeDefault,
                  ),
                  charts.LineAnnotationSegment(
                    state.maxLoss,
                    charts.RangeAnnotationAxisType.measure,
                    startLabel: 'Max Loss',
                    labelAnchor: charts.AnnotationLabelAnchor.start,
                    color: charts.MaterialPalette.red.shadeDefault,
                  ),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Max Profit: ${state.maxProfit == double.infinity ? 'Unlimited' : state.maxProfit}'),
                Text(
                    'Max Loss: ${state.maxLoss == double.infinity ? 'Unlimited' : state.maxLoss}'),
                Text('Break-Even Points: ${state.breakEvenPoints.join(', ')}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
