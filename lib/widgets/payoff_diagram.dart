import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data_models/data_models.dart';
import 'gradient_line.dart';

class OptionPayoffChart extends StatelessWidget {
  final List<ProfitLossData> data;
  final double? maxProfit;
  final double? maxLoss;
  final List<double> breakEvenPoints;
  final Color? backgroundColor;
  final bool showBreakEvenPoints;
  final bool showDataLabel;

  const OptionPayoffChart({
    super.key,
    required this.data,
    this.maxProfit,
    this.maxLoss,
    this.breakEvenPoints = const [],
    this.backgroundColor,
    this.showBreakEvenPoints = true,
    this.showDataLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: backgroundColor,
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(
          enable: true,
          format: 'point.x : \$point.y',
        ),
      ),
      enableAxisAnimation: true,
      tooltipBehavior: TooltipBehavior(enable: true),
      series: [
        SplineSeries<ProfitLossData, double>(
          dataSource: data,
          xValueMapper: (ProfitLossData payoff, _) => payoff.underlyingPrice,
          yValueMapper: (ProfitLossData payoff, _) => payoff.profitLoss,
          name: 'Profit/Loss',
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: DataLabelSettings(
            isVisible: showDataLabel,
            offset: const Offset(30, 0),
          ),
        ),
      ],
      annotations: <CartesianChartAnnotation>[
        if (showBreakEvenPoints)
          ...breakEvenPoints.map(
            (point) => CartesianChartAnnotation(
              widget: GradientLine(
                message: 'Break Even ${point.toStringAsFixed(2)}',
              ),
              coordinateUnit: CoordinateUnit.point,
              x: point,
              y: 0,
            ),
          ),
      ],
    );
  }
}
