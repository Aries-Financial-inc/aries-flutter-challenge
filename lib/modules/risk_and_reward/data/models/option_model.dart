import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'option_model.freezed.dart';
part 'option_model.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class OptionModel with _$OptionModel {
  factory OptionModel({
     required double strikePrice,
    required String type, // Call or Put
    required double bid,
    required double ask,
    required String longShort, // long or short
    required DateTime expirationDate,
  }) = _OptionModel;

  factory OptionModel.fromJson(Map<String, dynamic> json) =>
      _$OptionModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OptionModelToJson(this);
}

