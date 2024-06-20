import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/option_contract.dart';

abstract class OptionsStrategyState extends Equatable {
  @override
  List<Object> get props => [];
}

class OptionsStrategyInitial extends OptionsStrategyState {}

class OptionsStrategyLoaded extends OptionsStrategyState {
  final List<OptionContract> contracts;
  final List<FlSpot> graphData;
  final double maxProfit;
  final double maxLoss;
  final List<double> breakEvenPoints;

  OptionsStrategyLoaded({
    required this.contracts,
    required this.graphData,
    required this.maxProfit,
    required this.maxLoss,
    required this.breakEvenPoints,
  });

  @override
  List<Object> get props =>
      [contracts, graphData, maxProfit, maxLoss, breakEvenPoints];
}
