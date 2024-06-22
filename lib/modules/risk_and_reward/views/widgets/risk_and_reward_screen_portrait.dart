import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_point_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/domain/controllers/risk_and_reward_controller.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/risk_and_reward_state_model.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
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
            title: const Text(
              'Options Profit Calculator',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildChartWidget(state),
                  ),
          ),
        );
      },
    );
  }

  Widget buildChartWidget(RiskAndRewardState state) {
    final data =
        state.spots.map((spot) => ProfitLossPoint(spot.x, spot.y)).toList();

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
          dashPatternFn: (_, __) => [4, 4],
        ),
      );
    }

    // Calculate the margin for the axes
    final double xMargin = (state.maxX - state.minX) * 0.2;
    final double yMargin = (state.maxY - state.minY) * 0.2;

    return Column(
      children: [
        SizedBox(
          height: 500,
          child: charts.LineChart(
            series,
            animate: true,
            domainAxis: charts.NumericAxisSpec(
              viewport: charts.NumericExtents(
                  state.minX - xMargin, state.maxX + xMargin),
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                desiredTickCount:
                    ((state.maxX - state.minX + 2 * xMargin) / 0.5).ceil(),
                zeroBound: false,
              ),
              renderSpec: charts.SmallTickRendererSpec(
                labelStyle: const charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.MaterialPalette.black,
                ),
                lineStyle: charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shadeDefault,
                ),
              ),
            ),
            primaryMeasureAxis: charts.NumericAxisSpec(
              viewport: charts.NumericExtents(
                  state.minY - yMargin, state.maxY + yMargin),
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                desiredTickCount:
                    ((state.maxY - state.minY + 2 * yMargin) / 0.5).ceil(),
                zeroBound: false,
              ),
              renderSpec: charts.GridlineRendererSpec(
                labelStyle: const charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.MaterialPalette.black,
                ),
                lineStyle: charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shadeDefault,
                ),
              ),
            ),
            behaviors: [
              charts.ChartTitle(
                'Underlying Price',
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea,
                titleStyleSpec: const charts.TextStyleSpec(
                  fontSize: 16,
                  fontWeight: 'bold',
                  color: charts.MaterialPalette.black,
                ),
              ),
              charts.ChartTitle(
                'Profit / Loss',
                behaviorPosition: charts.BehaviorPosition.start,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea,
                titleStyleSpec: const charts.TextStyleSpec(
                  fontSize: 16,
                  fontWeight: 'bold',
                  color: charts.MaterialPalette.black,
                ),
              ),
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
                  startLabel:
                      'Max Profit: ${state.maxProfit == double.infinity ? 'Unlimited' : state.maxProfit.toStringAsFixed(2)}',
                  labelAnchor: charts.AnnotationLabelAnchor.start,
                  color: charts.MaterialPalette.green.shadeDefault,
                  dashPattern: [4, 4],
                  strokeWidthPx: 3,
                ),
                charts.LineAnnotationSegment(
                  state.maxLoss,
                  charts.RangeAnnotationAxisType.measure,
                  startLabel:
                      'Max Loss: ${state.maxLoss == double.infinity ? 'Unlimited' : state.maxLoss.toStringAsFixed(2)}',
                  labelAnchor: charts.AnnotationLabelAnchor.start,
                  color: charts.MaterialPalette.red.shadeDefault,
                  dashPattern: [4, 4],
                  strokeWidthPx: 3,
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
