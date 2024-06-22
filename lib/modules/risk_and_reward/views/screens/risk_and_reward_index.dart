import 'package:flutter_challenge/modules/risk_and_reward/data/models/option_model.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_challenge/global/utilities/layout_resolver.dart';
import 'package:flutter_challenge/modules/risk_and_reward/domain/controllers/risk_and_reward_controller.dart';
import 'package:flutter_challenge/modules/risk_and_reward/views/widgets/risk_and_reward_screen_portrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiskAndRewardIndex extends StatefulWidget {
  const RiskAndRewardIndex({super.key});

  @override
  State<RiskAndRewardIndex> createState() => _RiskAndRewardIndexState();
}

class _RiskAndRewardIndexState extends State<RiskAndRewardIndex> {
  late RiskAndRewardController _controller;
   final List<OptionModel> options = [
    OptionModel(
      strikePrice: 100,
      type: 'Call',
      bid: 10.05,
      ask: 12.04,
      longShort: 'long',
      expirationDate: DateTime.parse('2025-12-17'),
    ),
    OptionModel(
      strikePrice: 102.5,
      type: 'Call',
      bid: 12.1,
      ask: 14,
      longShort: 'long',
      expirationDate: DateTime.parse('2025-12-17'),
    ),
    OptionModel(
      strikePrice: 103,
      type: 'Put',
      bid: 14,
      ask: 15.5,
      longShort: 'short',
      expirationDate: DateTime.parse('2025-12-17'),
    ),
    OptionModel(
      strikePrice: 105,
      type: 'Put',
      bid: 16,
      ask: 18,
      longShort: 'long',
      expirationDate: DateTime.parse('2025-12-17'),
    ),
  ];

  @override
  void initState() {
    _controller = RiskAndRewardController();
    Get.put(_controller);
    _controller.calculateData(options);

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<RiskAndRewardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _controller,
      child: LayoutResolver(
        landscapeWidget: RiskAndRewardScreenPortrait(),
        portraitWidget: RiskAndRewardScreenPortrait(),
      ),
    );
  }
}
