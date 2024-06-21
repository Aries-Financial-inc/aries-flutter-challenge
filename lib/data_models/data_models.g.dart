// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionContractImpl _$$OptionContractImplFromJson(Map<String, dynamic> json) =>
    _$OptionContractImpl(
      strikePrice: json['strike_price'] as num,
      type: $enumDecode(_$OptionTypeEnumMap, json['type']),
      longShort: $enumDecode(_$LongShortEnumMap, json['long_short']),
      bid: json['bid'] as num,
      ask: json['ask'] as num,
    );

Map<String, dynamic> _$$OptionContractImplToJson(
        _$OptionContractImpl instance) =>
    <String, dynamic>{
      'strike_price': instance.strikePrice,
      'type': _$OptionTypeEnumMap[instance.type]!,
      'long_short': _$LongShortEnumMap[instance.longShort]!,
      'bid': instance.bid,
      'ask': instance.ask,
    };

const _$OptionTypeEnumMap = {
  OptionType.Call: 'Call',
  OptionType.Put: 'Put',
};

const _$LongShortEnumMap = {
  LongShort.long: 'long',
  LongShort.short: 'short',
};

_$ProfitLossDataImpl _$$ProfitLossDataImplFromJson(Map<String, dynamic> json) =>
    _$ProfitLossDataImpl(
      underlyingPrice: (json['underlyingPrice'] as num).toDouble(),
      profitLoss: (json['profitLoss'] as num).toDouble(),
    );

Map<String, dynamic> _$$ProfitLossDataImplToJson(
        _$ProfitLossDataImpl instance) =>
    <String, dynamic>{
      'underlyingPrice': instance.underlyingPrice,
      'profitLoss': instance.profitLoss,
    };
