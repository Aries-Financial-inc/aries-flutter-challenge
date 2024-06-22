import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<ChartData> data;
  final DateTimeIntervalType intervalType;

  const LineChartWidget(this.data, {super.key, required this.intervalType});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: NumericAxis(
        isVisible: true,
        // intervalType: intervalType,
      ),
      series: <ChartSeries>[
        SplineSeries<ChartData, double>(
          xAxisName: 'Price at expiry',
          yAxisName: 'Profit/Loss',
          color: Theme.of(context).primaryColor,
          enableTooltip: true,
          dataSource: data,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
          markerSettings: const MarkerSettings(
            isVisible: true,
          ),
        )
      ],
    );
  }
}

class ChartData {
  final double x;
  final num y;

  ChartData(this.x, this.y);
}
