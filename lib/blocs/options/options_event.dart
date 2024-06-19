import 'package:equatable/equatable.dart';

abstract class OptionsEvent extends Equatable {
  const OptionsEvent();
}

class AddOptionContract extends OptionsEvent {
  final String optionType; // Call or Put
  final double strikePrice;
  final double premium;
  final int quantity;

  const AddOptionContract(
      this.optionType, this.strikePrice, this.premium, this.quantity);

  @override
  List<Object> get props => [optionType, strikePrice, premium, quantity];
}

class RemoveOptionContract extends OptionsEvent {
  final int index;

  const RemoveOptionContract(this.index);

  @override
  List<Object> get props => [index];
}

class CalculateRiskReward extends OptionsEvent {
  const CalculateRiskReward();

  @override
  List<Object> get props => [];
}
