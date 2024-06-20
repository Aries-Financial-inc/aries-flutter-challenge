import 'package:flutter_challenge/constraints/colors.dart';
import 'package:flutter_challenge/ui/widgets/options_chart.dart';

import '../extensions/double_ex.dart';
import '../ui/utils/options_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/options_strategy_bloc.dart';
import '../states/options_strategy_state.dart';
import '../events/options_strategy_event.dart';
import '../models/option_contract.dart';

///
/// [OptionsStrategyWidget] widget is responsible for displaying the [OptionsGraph] widget, [max profit, max loss, break-even points] and [OptionsForm] to add new options
/// takes list of [contract] as input
/// on [OptionsStrategyInitial] state returns ['no data available']
/// on [OptionsStrategyLoaded] state returns the options graph and [OptionsForm]
/// else it displays an error
///
class OptionsStrategyWidget extends StatefulWidget {
  final List<OptionContractDTO> contracts;
  const OptionsStrategyWidget({super.key, required this.contracts});

  @override
  _OptionsStrategyWidgetState createState() => _OptionsStrategyWidgetState();
}

class _OptionsStrategyWidgetState extends State<OptionsStrategyWidget> {
  final List<Color> gradientColors = [
    AppColors.egoPrimaryColor,
    AppColors.egoPrimaryColor,
  ];

  @override
  void initState() {
    super.initState();

    _updateContracts();
  }

  // this function updates the state of the graph based on the demo data found in the challenge
  void _updateContracts() {
    context
        .read<OptionsStrategyBloc>()
        .add(OptionsContractsUpdated(widget.contracts));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.egoBackgroundColor,
      body: BlocBuilder<OptionsStrategyBloc, OptionsStrategyState>(
        builder: (context, state) {
          if (state is OptionsStrategyInitial) {
            return const Center(child: Text('No data available'));
          } else if (state is OptionsStrategyLoaded) {
            return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.58,
                    elevation: 0,
                    pinned: true,
                    stretch: true,
                    toolbarHeight: 80,
                    backgroundColor: AppColors.egoAccentColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .40,
                            child: OptionsGraph(
                                gradientColors: gradientColors,
                                data: state.graphData),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: <InlineSpan>[
                                    const TextSpan(
                                      text: 'Max Profit: \$',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: state.maxProfit == double.infinity
                                          ? "Unlimited"
                                          : state.maxProfit.toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    )
                                  ])),
                                  Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        const TextSpan(
                                          text: 'Max Loss: \$',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: state.maxLoss == double.infinity
                                              ? "Unlimited"
                                              : state.maxLoss
                                                  .toStringAsFixed(2),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        const TextSpan(
                                          text: 'Break-Even Points: ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: state.breakEvenPoints
                                              .map((breakPoint) =>
                                                  breakPoint.toPrecision(2))
                                              .toList()
                                              .join(", "),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.egoPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: OptionsForm(),
                        ),
                      ],
                    ),
                  )
                ]);
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    ));
  }
}
