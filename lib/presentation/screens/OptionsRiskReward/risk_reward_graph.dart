import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_challenge/business_logic/cubit/riskRewardGraph/risk_reward_graph_cubit.dart';
import 'package:flutter_challenge/models/option.model.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiskRewardGraphCubit, RiskRewardGraphState>(
      builder: (context, state) {
        List<OptionData> optionDataList = state.dataPoints;

        // Calculate profit/loss for each option data point
        List<FlSpot> spots = optionDataList.asMap().entries.map((entry) {
          OptionData optionData = entry.value;
          double profitLoss =
              optionData.calculateProfit(optionData.strikePrice);
          return FlSpot(entry.key.toDouble(), profitLoss);
        }).toList();

        double minProfitLoss = OptionData.calculateMinY(optionDataList);
        double maxProfitLoss = OptionData.calculateMaxY(optionDataList);
        double breakEvenPoint =
            OptionData.calculateBreakEvenPoint(optionDataList);

        return optionDataList.length < 2
            ? Container(
                color: Colors.white10,
                child: const Center(
                  child: Text("At least 2 forms are required"),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            preventCurveOverShooting: true,
                            spots: spots,
                            isCurved: true,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            axisNameWidget: const Text("profitLoss"),
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, titleMeta) {
                                // Replace with your logic to generate bottom axis titles
                                return Text(titleMeta.formattedValue);
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            axisNameWidget: const Text("Price"),
                            axisNameSize: 22,
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, titleMeta) {
                                // Replace with your logic to generate left axis titles
                                return Text(titleMeta.formattedValue);
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        minX: 0,
                        maxX: optionDataList.length.toDouble() - 1,
                        minY: minProfitLoss,
                        maxY: maxProfitLoss,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.all(),
                        children: [
                          const TableRow(children: [
                            TableCell(child: Center(child: Text('Metrics'))),
                            TableCell(child: Center(child: Text('Value'))),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child:
                                    Center(child: Text('Minimum Profit/Loss'))),
                            TableCell(
                                child: Center(
                                    child: Text(minProfitLoss.toString()))),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child:
                                    Center(child: Text('Maximum Profit/Loss'))),
                            TableCell(
                                child: Center(
                                    child: Text(maxProfitLoss.toString()))),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Center(child: Text('Break-Even Point'))),
                            TableCell(
                                child: Center(
                                    child: Text(breakEvenPoint.toString()))),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
