// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_and_reward_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RiskAndRewardStateToJson(RiskAndRewardState instance) =>
    <String, dynamic>{
      'options': instance.options,
      'maxProfit': instance.maxProfit,
      'maxLoss': instance.maxLoss,
      'breakEvenPoints': instance.breakEvenPoints,
      'isLoading': instance.isLoading,
      'spots': instance.spots.map(const FlSpotConverter().toJson).toList(),
      'minX': instance.minX,
      'maxX': instance.maxX,
      'minY': instance.minY,
      'maxY': instance.maxY,
    };

_$RiskAndRewardStateImpl _$$RiskAndRewardStateImplFromJson(
        Map<String, dynamic> json) =>
    _$RiskAndRewardStateImpl(
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      maxProfit: (json['maxProfit'] as num?)?.toDouble() ?? 0,
      maxLoss: (json['maxLoss'] as num?)?.toDouble() ?? 0,
      breakEvenPoints: (json['breakEvenPoints'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
      spots: (json['spots'] as List<dynamic>?)
              ?.map((e) =>
                  const FlSpotConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      minX: (json['minX'] as num?)?.toDouble() ?? 0,
      maxX: (json['maxX'] as num?)?.toDouble() ?? 0,
      minY: (json['minY'] as num?)?.toDouble() ?? 0,
      maxY: (json['maxY'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$RiskAndRewardStateImplToJson(
        _$RiskAndRewardStateImpl instance) =>
    <String, dynamic>{
      'options': instance.options,
      'maxProfit': instance.maxProfit,
      'maxLoss': instance.maxLoss,
      'breakEvenPoints': instance.breakEvenPoints,
      'isLoading': instance.isLoading,
      'spots': instance.spots.map(const FlSpotConverter().toJson).toList(),
      'minX': instance.minX,
      'maxX': instance.maxX,
      'minY': instance.minY,
      'maxY': instance.maxY,
    };
