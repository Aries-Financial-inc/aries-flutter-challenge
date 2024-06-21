import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/constants/strings.dart';
import 'package:flutter_challenge/risk_reward_graph/controller/options_screen_controller.dart';
import 'package:flutter_challenge/risk_reward_graph/model/option_contract.dart';
import 'package:flutter_challenge/risk_reward_graph/screen/widgets/graph.dart';
import 'package:flutter_challenge/risk_reward_graph/screen/widgets/metrics.dart';
import 'package:get/get.dart';

class OptionsCalculatorScreen extends StatelessWidget {
  const OptionsCalculatorScreen({super.key, required this.optionsData});

  final List<OptionContractModel> optionsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              StringValues.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 54),
            child: GetBuilder<OptionsCalculatorScreenController>(
              init: OptionsCalculatorScreenController(optionsData),
              builder: (controller) => Column(
                children: [
                  Expanded(
                      child: Graph(plots: controller.result.profitLossData)),
                  const SizedBox(height: 32),
                  Metrics(
                      maxProfit: controller.maxProfitStr,
                      maxLoss: controller.maxLossStr,
                      breakEvenPoints: controller.breakEvenPointsStr)
                ],
              ),
            ),
          ),
        ));
  }
}
