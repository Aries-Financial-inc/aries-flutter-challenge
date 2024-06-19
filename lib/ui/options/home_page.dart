import 'package:flutter/material.dart';

import 'widgets/options_input.dart';
import 'widgets/risk_reward_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            'Options Risk & Reward Analysis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            OptionsInput(),
            SizedBox(height: 20),
            RiskRewardChart(),
          ],
        ),
      ),
    );
  }
}
