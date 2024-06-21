import 'package:get/instance_manager.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/risk_and_reward_state_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/domain/controllers/risk_and_reward_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiskAndRewardScreenPortrait extends StatefulWidget {
  const RiskAndRewardScreenPortrait({super.key});

  @override
  State<RiskAndRewardScreenPortrait> createState() => _RiskAndRewardScreenPortraitState();
}

class _RiskAndRewardScreenPortraitState extends State<RiskAndRewardScreenPortrait> {
   final RiskAndRewardController _controller = Get.find<RiskAndRewardController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiskAndRewardController, RiskAndRewardState>(
        bloc: _controller,
        builder: (context, state) {
           return Scaffold(
            appBar: AppBar(
              title: const Text('RiskAndRewardPortrait'),
            ),
          );
        });
  }
}

