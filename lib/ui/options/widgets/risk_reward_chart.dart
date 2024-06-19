import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../blocs/options/options_bloc.dart';
import '../../../blocs/options/options_state.dart';

class RiskRewardChart extends StatelessWidget {
  const RiskRewardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, OptionsState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 300,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (tooltip) => Colors.white),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey[300]!,
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey[300]!,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            'Price of Underlying',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        axisNameWidget: const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Text(
                            'Profit / Loss',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Text(
                                value.toStringAsFixed(0),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: state.xValues.asMap().entries.map((entry) {
                          return FlSpot(entry.value, state.yValues[entry.key]);
                        }).toList(),
                        isCurved: true,
                        barWidth: 3,
                        color: Theme.of(context).colorScheme.primary,
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('Max Profit: \$${state.maxProfit.toStringAsFixed(2)}'),
            Text('Max Loss: \$${state.maxLoss.toStringAsFixed(2)}'),
            Text('Break-Even Points: ${state.breakEvenPoints.join(', ')}'),
          ],
        );
      },
    );
  }
}
