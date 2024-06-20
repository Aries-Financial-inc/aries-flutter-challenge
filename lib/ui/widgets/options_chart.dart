import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OptionsChart extends StatelessWidget {
  const OptionsChart({
    super.key,
    required this.gradientColors,
    required this.data,
  });

  final List<Color> gradientColors;
  final data;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
        ),
        titlesData: FlTitlesData(
          show: false,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              // interval: 0, // Adjust interval as needed
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ),
        minX: 80,
        maxX: 120,
        minY: -50,
        maxY: 120,
        lineTouchData: LineTouchData(
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.white.withOpacity(0.1),
                  strokeWidth: 2,
                  dashArray: [3, 3],
                ),
                FlDotData(
                  show: false,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 8,
                    color: [
                      Colors.black,
                      Colors.black,
                    ][index],
                    strokeWidth: 2,
                    strokeColor: Colors.black,
                  ),
                ),
              );
            }).toList();
          },
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipPadding: const EdgeInsets.all(8),
            // tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                return LineTooltipItem(
                  '\$${touchedSpot.y.round()}.00',
                  const TextStyle(color: Colors.white, fontSize: 12.0),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            gradient: LinearGradient(colors: gradientColors),
            barWidth: 2,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              // gradientFrom: Offset(0, 0),
              // gradientTo: Offset(0, 1),
              gradient: LinearGradient(colors: [
                const Color(0xffe68823).withOpacity(0.1),
                const Color(0xffe68823).withOpacity(0),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
