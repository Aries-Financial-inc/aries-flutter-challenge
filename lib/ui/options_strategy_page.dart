import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/options_strategy_bloc.dart';
import '../models/option_contract.dart';
import '../repositories/options_strategy_repository.dart';
import 'options_strategy_widget.dart';

/// this class represents the options strategy entry point
/// passes [OptionsStrategyBloc] and inject [OptionsStrategyRepository] into the widget tree
/// takes [OptionContractDTO] list and provides it to the [OptionsStrategyWidget]
class OptionsStrategyPage extends StatelessWidget {
  final List<OptionContractDTO> contracts;
  const OptionsStrategyPage({super.key, required this.contracts});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OptionsStrategyBloc(OptionsStrategyRepository()),
      child: OptionsStrategyWidget(
        contracts: contracts,
      ),
    );
  }
}
