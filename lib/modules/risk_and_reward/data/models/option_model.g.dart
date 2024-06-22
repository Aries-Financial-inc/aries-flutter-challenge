// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      'strikePrice': instance.strikePrice,
      'type': instance.type,
      'bid': instance.bid,
      'ask': instance.ask,
      'longShort': instance.longShort,
      'expirationDate': instance.expirationDate.toIso8601String(),
    };

_$OptionModelImpl _$$OptionModelImplFromJson(Map<String, dynamic> json) =>
    _$OptionModelImpl(
      strikePrice: (json['strikePrice'] as num).toDouble(),
      type: json['type'] as String,
      bid: (json['bid'] as num).toDouble(),
      ask: (json['ask'] as num).toDouble(),
      longShort: json['longShort'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$$OptionModelImplToJson(_$OptionModelImpl instance) =>
    <String, dynamic>{
      'strikePrice': instance.strikePrice,
      'type': instance.type,
      'bid': instance.bid,
      'ask': instance.ask,
      'longShort': instance.longShort,
      'expirationDate': instance.expirationDate.toIso8601String(),
    };
