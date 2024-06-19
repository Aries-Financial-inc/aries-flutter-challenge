import 'package:equatable/equatable.dart';

class OptionsState extends Equatable {
  final List<OptionContract> contracts;
  final List<double> xValues;
  final List<double> yValues;
  final double maxProfit;
  final double maxLoss;
  final List<double> breakEvenPoints;

  const OptionsState({
    this.contracts = const [],
    this.xValues = const [],
    this.yValues = const [],
    this.maxProfit = 0.0,
    this.maxLoss = 0.0,
    this.breakEvenPoints = const [],
  });

  OptionsState copyWith({
    List<OptionContract>? contracts,
    List<double>? xValues,
    List<double>? yValues,
    double? maxProfit,
    double? maxLoss,
    List<double>? breakEvenPoints,
  }) {
    return OptionsState(
      contracts: contracts ?? this.contracts,
      xValues: xValues ?? this.xValues,
      yValues: yValues ?? this.yValues,
      maxProfit: maxProfit ?? this.maxProfit,
      maxLoss: maxLoss ?? this.maxLoss,
      breakEvenPoints: breakEvenPoints ?? this.breakEvenPoints,
    );
  }

  @override
  List<Object> get props =>
      [contracts, xValues, yValues, maxProfit, maxLoss, breakEvenPoints];
}

class OptionContract extends Equatable {
  final String optionType; // Call or Put
  final double strikePrice;
  final double premium;
  final int quantity;

  const OptionContract(
      this.optionType, this.strikePrice, this.premium, this.quantity);

  @override
  List<Object> get props => [optionType, strikePrice, premium, quantity];
}
