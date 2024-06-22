import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'option_contract.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  List<Map<String, dynamic>> optionsData = [];
  late List<OptionContract> contracts;

  @override
  void initState() {
    super.initState();
    optionsData = widget.optionsData;
    contracts = OptionContract.fromJson(widget.optionsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Options Profit Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              child: SfCartesianChart(
                legend: const Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<double, int>>[
                  LineSeries<double, int>(
                    dataSource: contracts.getChartData(),
                    xValueMapper: (_, x) => x,
                    yValueMapper: (data, _) => data,
                    name: 'Risk & reward graph',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("Max Profit: ${contracts.getMaxProfit()}"),
            Text("Max Loss: ${contracts.getMaxLoss()}"),
            Text(
              "Break Even Points: ${contracts.getBreakEvenPoints().join(", ")}",
            ),
          ],
        ),
      ),
    );
  }
}
