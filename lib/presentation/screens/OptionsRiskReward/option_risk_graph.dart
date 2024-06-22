import 'package:flutter/material.dart';
import 'package:flutter_challenge/constants/screen_size.dart';
import 'package:flutter_challenge/presentation/screens/OptionsRiskReward/input_table.dart';
import 'package:flutter_challenge/presentation/screens/OptionsRiskReward/risk_reward_graph.dart';

class OptionFormScreen extends StatelessWidget {
  const OptionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Option Contract Form',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[700],
        ),
        backgroundColor: Colors.blueGrey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                InputTable(),
                SizedBox(height: context.screenHeight(0.05)),
                SizedBox(
                  height: context.screenHeight(0.4),
                  child: const GraphWidget(),
                ),
                SizedBox(height: context.screenHeight(0.05)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
