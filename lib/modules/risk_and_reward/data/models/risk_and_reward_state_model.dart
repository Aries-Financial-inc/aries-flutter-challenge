import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'risk_and_reward_state_model.freezed.dart';
part 'risk_and_reward_state_model.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class RiskAndRewardState with _$RiskAndRewardState {
  factory RiskAndRewardState({
     @Default(false) bool isLoading,
     String? id,
  }) = _RiskAndRewardState;

  factory RiskAndRewardState.fromJson(Map<String, dynamic> json) =>
      _$RiskAndRewardStateFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RiskAndRewardStateToJson(this);
}

