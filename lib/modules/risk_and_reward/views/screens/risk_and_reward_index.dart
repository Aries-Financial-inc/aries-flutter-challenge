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

  @override
  void initState() {
    _controller = RiskAndRewardController();
    Get.put(_controller);
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
        child: const LayoutResolver(
        landscapeWidget: RiskAndRewardScreenPortrait(),
        portraitWidget: RiskAndRewardScreenPortrait(),
      ),
    );
  }
}
