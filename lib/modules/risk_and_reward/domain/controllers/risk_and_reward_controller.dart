import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/option_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/profit_loss_point_model.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/models/risk_and_reward_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/modules/risk_and_reward/data/repositories/risk_and_reward_repository.dart';

class RiskAndRewardController extends Cubit<RiskAndRewardState> {
  final RiskAndRewardRepository repository = RiskAndRewardRepository();

  RiskAndRewardController() : super(RiskAndRewardState());

  void showLoader() {
    emit(state.copyWith(isLoading: true));
  }

  void hideLoader() {
    emit(state.copyWith(isLoading: false));
  }

  void calculateData(List<OptionModel> options) {
    emit(state.copyWith(isLoading: true));
    try {
      double minPrice = calculateMinPrice(options);
      double maxPrice = calculateMaxPrice(options);
      double step = calculateStep(minPrice, maxPrice, 100);
      var result =
          repository.calculateProfitLoss(options, minPrice, maxPrice, step);

      List<FlSpot> spots =
          result.profitLossData.map((point) => point.toFlSpot()).toList();

      double minX = result.profitLossData.first.underlyingPrice;
      double maxX = result.profitLossData.last.underlyingPrice;
      double minY = result.profitLossData
          .map((point) => point.profitLoss)
          .reduce((a, b) => a < b ? a : b);
      double maxY = result.profitLossData
          .map((point) => point.profitLoss)
          .reduce((a, b) => a > b ? a : b);

      emit(state.copyWith(
        options: options,
        breakEvenPoints: result.breakEvenPoints,
        maxProfit: result.maxProfit,
        maxLoss: result.maxLoss,
        spots: spots,
        isLoading: false,
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  double calculateMinPrice(List<OptionModel> options) {
    return options
        .map((option) => option.strikePrice)
        .reduce((min, price) => min < price ? min : price);
  }

  double calculateMaxPrice(List<OptionModel> options) {
    return options
        .map((option) => option.strikePrice)
        .reduce((max, price) => max > price ? max : price);
  }

  double calculateStep(double minPrice, double maxPrice, int numberOfPoints) {
    return (maxPrice - minPrice) / numberOfPoints;
  }
}
