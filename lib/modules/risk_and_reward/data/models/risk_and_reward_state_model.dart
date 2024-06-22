import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/fl_spot_converter.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/option_model.dart';

part 'risk_and_reward_state_model.freezed.dart';
part 'risk_and_reward_state_model.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class RiskAndRewardState with _$RiskAndRewardState {
  factory RiskAndRewardState({
    @Default([]) List<OptionModel> options,
    @Default(0) double maxProfit,
    @Default(0) double maxLoss,
    @Default([]) List<double> breakEvenPoints,
    @Default(false) bool isLoading,
    @Default([]) @FlSpotConverter() List<FlSpot> spots,
    @Default(0) double minX,
    @Default(0) double maxX,
    @Default(0) double minY,
    @Default(0) double maxY,
  }) = _RiskAndRewardState;

  factory RiskAndRewardState.fromJson(Map<String, dynamic> json) =>
      _$RiskAndRewardStateFromJson(json);

  Map<String, dynamic> toJson() => _$RiskAndRewardStateToJson(this);
}
