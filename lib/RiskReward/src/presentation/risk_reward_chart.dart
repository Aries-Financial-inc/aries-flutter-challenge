import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter_challenge/RiskReward/src/application/risk_reward_service.dart';
import 'package:flutter_challenge/RiskReward/src/domain/option_data.dart';

class RiskRewardChart extends StatelessWidget {
  final List<OptionData> optionsData;
  final RiskRewardService riskRewardService;

  RiskRewardChart({
    super.key,
    this.optionsData = const [],
    RiskRewardService? riskRewardServiceInstance,
  }) : riskRewardService = riskRewardServiceInstance ?? RiskRewardService();

  @override
  Widget build(BuildContext context) {
    return optionsData.isEmpty
        ? const Center(
            child: Text('No options data'),
          )
        : charts.LineChart(riskRewardService.mapOptionData(optionsData),
            animate: true);
  }
}
