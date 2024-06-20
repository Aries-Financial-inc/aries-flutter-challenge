import 'package:bloc/bloc.dart';
import '../repositories/options_strategy_repository.dart';
import '../states/options_strategy_state.dart';
import '../events/options_strategy_event.dart';

/// Bloc responsible for handling options strategy analysis logic.
class OptionsStrategyBloc
    extends Bloc<OptionsStrategyEvent, OptionsStrategyState> {
  final OptionsStrategyRepository repository;

  OptionsStrategyBloc(this.repository) : super(OptionsStrategyInitial()) {
    on<OptionsContractsUpdated>((event, emit) {
      // Convert DTOs to domain models.
      final contracts = event.contracts.map((dto) => dto.toDomain()).toList();
      // Generate graph data.
      final graphData = repository.generateGraphData(contracts);
      // Calculate maximum profit.
      final maxProfit = repository.calculateMaxProfit(contracts);
      // Calculate maximum loss.
      final maxLoss = repository.calculateMaxLoss(contracts);
      // Calculate break even points.
      final breakEvenPoints = repository.calculateBreakEvenPoints(contracts);
      // Emit the loaded state with the computed values.
      emit(OptionsStrategyLoaded(
        contracts: contracts,
        graphData: graphData,
        maxProfit: maxProfit,
        maxLoss: maxLoss,
        breakEvenPoints: breakEvenPoints,
      ));
    });

    // Add new Option
    on<UpdateOptionsContracts>((event, emit) {
      final contracts = event.contracts.map((dto) => dto.toDomain()).toList();
      final graphData = repository.generateGraphData(contracts);
      final maxProfit = repository.calculateMaxProfit(contracts);
      final maxLoss = repository.calculateMaxLoss(contracts);
      final breakEvenPoints = repository.calculateBreakEvenPoints(contracts);
      emit(OptionsStrategyLoaded(
        contracts: contracts,
        graphData: graphData,
        maxProfit: maxProfit,
        maxLoss: maxLoss,
        breakEvenPoints: breakEvenPoints,
      ));
    });
  }
}
