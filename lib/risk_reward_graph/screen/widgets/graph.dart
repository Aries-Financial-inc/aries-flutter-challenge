import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_challenge/constants/colors.dart';

class Graph extends StatelessWidget {
  final List<MapEntry<double, double>> plots;
  const Graph({super.key, required this.plots});

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    final TextStyle? style =
        Theme.of(context).textTheme.labelSmall?.copyWith(color: secondaryColor);
    final BorderSide borderSide = BorderSide(color: secondaryColor);

    return LineChart(LineChartData(
        gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
                color: secondaryColor.withOpacity(0.15), strokeWidth: 1)),
        titlesData: FlTitlesData(
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          leftTitles:
              SideTitles(showTitles: true, getTextStyles: (bc, i) => style),
          bottomTitles:
              SideTitles(showTitles: true, getTextStyles: (bc, i) => style),
        ),
        borderData: FlBorderData(
            show: false, border: Border(left: borderSide, bottom: borderSide)),
        lineBarsData: [
          LineChartBarData(
              spots:
                  plots.map((entry) => FlSpot(entry.key, entry.value)).toList(),
              isCurved: true,
              colors: [Theme.of(context).colorScheme.secondary],
              belowBarData: BarAreaData(
                  show: true,
                  colors: [Theme.of(context).primaryColor.withOpacity(0.2)]),
              dotData: FlDotData(show: false),
              barWidth: 3),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.8)),
        )));
  }
}
