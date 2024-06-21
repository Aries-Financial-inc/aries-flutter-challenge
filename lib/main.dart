import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/util/option_calculator.dart';
import 'data_models/data_models.dart';

import 'widgets/payoff_diagram.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Options Profit Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const OptionsCalculator(optionsData: [
        {
          "strike_price": 100,
          "type": "Call",
          "bid": 10.05,
          "ask": 12.04,
          "long_short": "long",
          "expiration_date": "2025-12-17T00:00:00Z"
        },
        {
          "strike_price": 102.50,
          "type": "Call",
          "bid": 12.10,
          "ask": 14,
          "long_short": "long",
          "expiration_date": "2025-12-17T00:00:00Z"
        },
        {
          "strike_price": 103,
          "type": "Put",
          "bid": 14,
          "ask": 15.50,
          "long_short": "short",
          "expiration_date": "2025-12-17T00:00:00Z"
        },
        {
          "strike_price": 105,
          "type": "Put",
          "bid": 16,
          "ask": 18,
          "long_short": "long",
          "expiration_date": "2025-12-17T00:00:00Z"
        }
      ]),
    );
  }
}

class OptionsCalculator extends StatefulWidget {
  const OptionsCalculator({super.key, required this.optionsData});

  final List<Map<String, dynamic>> optionsData;

  @override
  State<OptionsCalculator> createState() => _OptionsCalculatorState();
}

class _OptionsCalculatorState extends State<OptionsCalculator> {
  List<OptionContract> optionsData = [];

  late double minStrikePrice;
  late double maxStrikePrice;
  late double buffer;

  late double minPrice;
  late double maxPrice;
  late double stepSize;

  late final OptionCalculator calculator;
  late final List<Map<String, double>> profitLossData;
  late final Map<String, double> maxMinProfitLoss;
  late final List<double> breakEvenPoints;
  late final List<ProfitLossData> chartData;

  @override
  void initState() {
    super.initState();
    optionsData = widget.optionsData.map(
      (data) {
        return OptionContract.fromJson(data);
      },
    ).toList();
    init();
  }

  void init() {
    minStrikePrice =
        optionsData.map((o) => o.strikePrice).reduce(min).toDouble();
    maxStrikePrice =
        optionsData.map((o) => o.strikePrice).reduce(max).toDouble();
    buffer = 20; // Example buffer value

    minPrice = minStrikePrice - buffer;
    maxPrice = maxStrikePrice + buffer;
    stepSize = 3;

    calculator = OptionCalculator();
    profitLossData = calculator.calculateTotalProfitLoss(
        optionsData, minPrice, maxPrice, stepSize);
    maxMinProfitLoss = calculator.findMaxMinProfitLoss(profitLossData);
    breakEvenPoints = calculator.findBreakEvenPoints(profitLossData);
    chartData = calculator.prepareChartData(profitLossData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Options Profit Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 400,
          child: OptionPayoffChart(
            data: chartData,
            maxProfit: maxMinProfitLoss['maxProfit'],
            maxLoss: maxMinProfitLoss['maxLoss'],
            breakEvenPoints: breakEvenPoints,
          ),
        ),
      ),
    );
  }
}
