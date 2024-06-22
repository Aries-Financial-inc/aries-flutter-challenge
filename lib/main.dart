import 'package:flutter/material.dart';
import 'package:flutter_challenge/modules/risk_and_reward/views/screens/risk_and_reward_index.dart';

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
      home: const RiskAndRewardIndex(),
    );
  }
}
