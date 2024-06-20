import 'package:flutter/material.dart';
import 'package:flutter_challenge/constraints/colors.dart';
import 'package:flutter_challenge/ui/options_strategy_page.dart';
import 'package:flutter_challenge/utils/option_calculator.dart';

import 'models/option_contract.dart';

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
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        primaryColor: AppColors.egoPrimaryColor,
        inputDecorationTheme: AppColors.egoInputDecorationTheme,
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

  /// [contracts] used to store parsed [optionsData] as [OptionContractDTO] list
  List<OptionContractDTO> contracts = [];
  @override
  void initState() {
    super.initState();
    optionsData = widget.optionsData;

    contracts = OptionCalculator.parseOptionContractsFromJson(optionsData);
  }

  // Your code here

  @override
  Widget build(BuildContext context) {
    return OptionsStrategyPage(contracts: contracts);
  }
}
