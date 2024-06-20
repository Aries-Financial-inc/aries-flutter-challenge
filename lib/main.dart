import 'package:flutter/material.dart';
import 'package:flutter_risk_reward_chart/flutter_risk_reward_chart.dart';

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

  @override
  void initState() {
    super.initState();
    optionsData = widget.optionsData;
  }

  // Your code here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Options Profit Calculator"),
      ),
      body: SafeArea(
          child: RiskRewardChart(
        optionsData: optionsData.map((el) {
          OptionType type;
          if (el["type"] == "Call") {
            if (el["long_short"] == "long") {
              type = OptionType.callLong;
            } else if (el["long_short"] == "short") {
              type = OptionType.callShort;
            } else {
              throw Exception("Invalid longShort type");
            }
          } else if (el["type"] == "Put") {
            if (el["long_short"] == "long") {
              type = OptionType.putLong;
            } else if (el["long_short"] == "short") {
              type = OptionType.putShort;
            } else {
              throw Exception("Invalid longShort type");
            }
          } else {
            throw Exception("Invalid option type");
          }
          return OptionData(
              strikePrice: double.parse(el["strike_price"].toString()),
              type: type,
              bid: double.parse(el["bid"].toString()),
              ask: double.parse(el["ask"].toString()),
              expirationDate: DateTime.parse(el["expiration_date"]));
        }).toList(),
      )),
    );
  }
}
