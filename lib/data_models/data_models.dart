import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math';

part 'data_models.freezed.dart';
part 'data_models.g.dart';

enum OptionType { Call, Put }

enum LongShort { long, short }

@freezed
class OptionContract with _$OptionContract {
  const OptionContract._();
  const factory OptionContract({
    @JsonKey(name: 'strike_price') required num strikePrice,
    required OptionType type,
    @JsonKey(name: 'long_short') required LongShort longShort,
    required num bid,
    required num ask,
  }) = _OptionContract;

  factory OptionContract.fromJson(Map<String, dynamic> json) =>
      _$OptionContractFromJson(json);

  double get premium => (bid + ask) / 2;

  double calculatePayoff(double underlyingPrice) {
    if (type == OptionType.Call) {
      if (longShort == LongShort.long) {
        return max(0, underlyingPrice - strikePrice) - premium;
      } else {
        return premium - max(0, underlyingPrice - strikePrice);
      }
    } else {
      // 'Put'
      if (longShort == LongShort.long) {
        return max(0, strikePrice - underlyingPrice) - premium;
      } else {
        return premium - max(0, strikePrice - underlyingPrice);
      }
    }
  }
}

@freezed
class ProfitLossData with _$ProfitLossData {
  const factory ProfitLossData({
    required double underlyingPrice,
    required double profitLoss,
  }) = _ProfitLossData;

  factory ProfitLossData.fromJson(Map<String, dynamic> json) =>
      _$ProfitLossDataFromJson(json);
}
