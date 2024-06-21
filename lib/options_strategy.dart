import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter_challenge/enum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final optionsContractProvider =
    StateNotifierProvider<OptionsContractState, List<OptionsContract>>((ref) {
  return OptionsContractState(ref: ref);
});

class OptionsContractState extends StateNotifier<List<OptionsContract>> {
  final Ref ref;
  OptionsContractState({required this.ref}) : super([]);

  Future<void> addItem(OptionsContract optionsContract) async {
    state = [...state, optionsContract];
  }

  double calculateProfitLoss(
      {required optionTypes type,
      required double x,
      required double strikePrice,
      required double avgOfBidAndAsk}) {
    log("type::: $type");
    if (type == optionTypes.call) {
      return math.max(0, x - strikePrice) - avgOfBidAndAsk;
    } else {
      return math.max(0, strikePrice - x) - avgOfBidAndAsk;
    }
  }
}

class OptionsContract {
  final optionTypes type;
  final double strikePrice;
  final double avgOfBidAndAsk;
  final double avg;
  final double bid;

  OptionsContract({
    required this.type,
    required this.strikePrice,
    required this.avgOfBidAndAsk,
    required this.avg,
    required this.bid,
  });

  double calculateProfitLoss(
      double x, double strikePrice, double avgOfBidAndAsk) {
    return math.max(0, x - strikePrice) - avgOfBidAndAsk;
  }
}
