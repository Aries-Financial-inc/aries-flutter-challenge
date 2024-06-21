// File: screens/options_calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_challenge/constants/colors.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/services/options_calculator.dart';

class OptionsCalculatorScreen extends StatefulWidget {
  const OptionsCalculatorScreen({super.key, required this.optionsData});

  final List<Map<String, dynamic>> optionsData;

  @override
  State<OptionsCalculatorScreen> createState() =>
      _OptionsCalculatorScreenState();
}

class _OptionsCalculatorScreenState extends State<OptionsCalculatorScreen> {
  List<MapEntry<double, double>> profitLossData = [];
  double maxProfit = 0.0;
  double maxLoss = 0.0;
  List<double> breakEvenPoints = [];

  static const title = "Risk & Reward";

  @override
  void initState() {
    super.initState();
    final optionsList = widget.optionsData
        .map((data) => OptionContract.fromJson(data))
        .toList();
    final result = OptionsCalculatorService.calculateProfitLoss(optionsList);
    profitLossData = result['profitLossData'];
    maxProfit = result['maxProfit'];
    maxLoss = result['maxLoss'];
    breakEvenPoints = result['breakEvenPoints'];
  }

  List<FlSpot> _getSpots() {
    return profitLossData
        .map((entry) => FlSpot(entry.key, entry.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            backgroundColor: Colors.transparent),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 54),
            child: Column(
              children: [
                if (profitLossData.isNotEmpty)
                  _buildProfitLossChart()
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 20),
                _buildProfitLossMetrics(),
              ],
            ),
          ),
        ));
  }

  Widget _buildProfitLossChart() {
    final TextStyle? style = Theme.of(context)
        .textTheme
        .labelSmall
        ?.copyWith(color: AppColors.white);
    final BorderSide borderSide = BorderSide(color: AppColors.white);
    return Expanded(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => FlLine(
                  color: AppColors.white.withOpacity(0.15), strokeWidth: 1)),
          titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            leftTitles:
                SideTitles(showTitles: true, getTextStyles: (bc, i) => style),
            bottomTitles:
                SideTitles(showTitles: true, getTextStyles: (bc, i) => style),
          ),
          borderData: FlBorderData(
              show: false,
              border: Border(left: borderSide, bottom: borderSide)),
          lineBarsData: [
            LineChartBarData(
                spots: _getSpots(),
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
              tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfitLossMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profit & Loss Metrics",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        _buildMetricTile("Max Profit", "\$${maxProfit.toStringAsFixed(2)}",
            Icons.arrow_upward, Colors.green),
        _buildMetricTile("Max Loss", "\$${maxLoss.toStringAsFixed(2)}",
            Icons.arrow_downward, Colors.red),
        _buildMetricTile(
          "Break Even Points",
          breakEvenPoints.map((e) => e.toStringAsFixed(2)).join(", "),
          Icons.breakfast_dining,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildMetricTile(
      String title, String value, IconData icon, Color iconColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
