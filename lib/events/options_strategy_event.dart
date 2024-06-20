import 'package:equatable/equatable.dart';
import '../models/option_contract.dart';

abstract class OptionsStrategyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateOptionsContracts extends OptionsStrategyEvent {
  final List<OptionContractDTO> contracts;

  UpdateOptionsContracts(this.contracts);

  @override
  List<Object> get props => [contracts];
}

class OptionsContractsUpdated extends OptionsStrategyEvent {
  final List<OptionContractDTO> contracts;

  OptionsContractsUpdated(this.contracts);

  @override
  List<Object> get props => [contracts];
}
