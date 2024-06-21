import 'package:flutter/material.dart';
import 'package:flutter_challenge/constants/colors.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/screen/options_calculator_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}
final optionList = [
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
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Options Profit Calculator',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.dark(
              background: Colors.black,
              primary: AppColors.primary,
              secondary: AppColors.white),
          textTheme: GoogleFonts.publicSansTextTheme().apply(
              bodyColor: AppColors.white, displayColor: AppColors.white)),
      home:   OptionsCalculatorScreen(
        optionsData: optionList.map((e) => OptionContractModel.fromJson(e)).toList(),
      ),
    );
  }
}
