import 'package:bloc/bloc.dart';
import 'options_event.dart';
import 'options_state.dart';

class OptionsBloc extends Bloc<OptionsEvent, OptionsState> {
  OptionsBloc() : super(const OptionsState()) {
    on<AddOptionContract>(_onAddOptionContract);
    on<RemoveOptionContract>(_onRemoveOptionContract);
    on<CalculateRiskReward>(_onCalculateRiskReward);
  }

  void _onAddOptionContract(
      AddOptionContract event, Emitter<OptionsState> emit) {
    final newContracts = List<OptionContract>.from(state.contracts)
      ..add(OptionContract(
          event.optionType, event.strikePrice, event.premium, event.quantity));
    emit(state.copyWith(contracts: newContracts));
  }

  void _onRemoveOptionContract(
      RemoveOptionContract event, Emitter<OptionsState> emit) {
    final newContracts = List<OptionContract>.from(state.contracts)
      ..removeAt(event.index);
    emit(state.copyWith(contracts: newContracts));
  }

  void _onCalculateRiskReward(
      CalculateRiskReward event, Emitter<OptionsState> emit) {
    // Define the range of prices for the underlying asset
    const minPrice = 0.0;
    const maxPrice = 100.0;
    const step = 1.0;

    // Generate a list of possible spot prices at expiry
    final xValues = List<double>.generate(
        ((maxPrice - minPrice) / step).ceil() + 1,
        (index) => minPrice + index * step);

    // Calculate the profit/loss for each spot price
    final yValues = xValues.map((spotPrice) {
      double totalPnL = 0.0;

      for (var contract in state.contracts) {
        double payoff;
        if (contract.optionType == 'Call') {
          payoff = (spotPrice > contract.strikePrice)
              ? (spotPrice - contract.strikePrice) - contract.premium
              : -contract.premium;
        } else {
          payoff = (spotPrice < contract.strikePrice)
              ? (contract.strikePrice - spotPrice) - contract.premium
              : -contract.premium;
        }
        totalPnL += payoff * contract.quantity;
      }

      return totalPnL;
    }).toList();

    // Calculate max profit, max loss, and break-even points
    double maxProfit = yValues.reduce((a, b) => a > b ? a : b);
    double maxLoss = yValues.reduce((a, b) => a < b ? a : b);
    List<double> breakEvenPoints = [];

    for (int i = 1; i < xValues.length; i++) {
      if ((yValues[i - 1] < 0 && yValues[i] >= 0) ||
          (yValues[i - 1] > 0 && yValues[i] <= 0)) {
        breakEvenPoints.add(xValues[i]);
      }
    }

    emit(state.copyWith(
      xValues: xValues,
      yValues: yValues,
      maxProfit: maxProfit,
      maxLoss: maxLoss,
      breakEvenPoints: breakEvenPoints,
    ));
  }
}
