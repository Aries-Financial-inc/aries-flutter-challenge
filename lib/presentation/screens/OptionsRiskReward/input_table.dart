import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/business_logic/cubit/riskRewardGraph/risk_reward_graph_cubit.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';

import 'package:flutter_challenge/models/option.model.dart';
import 'package:flutter_challenge/presentation/screens/OptionsRiskReward/widgets/export.gate.dart';

class InputTable extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  InputTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisibilityCubit, bool>(
      builder: (context, isVisible) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              if (isVisible) ...[
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2), // Adjust column widths as needed
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    _buildTableRow("Strike Price", strikePriceInput(context)),
                    _buildTableRow("Type", typeDropdown(context)),
                    _buildTableRow("Bid", bidInput(context)),
                    _buildTableRow("Ask", askInput(context)),
                    _buildTableRow("Long/Short", longShortDropdown(context)),
                    _buildTableRow(
                        "Expiration Date", expirationDatePicker(context)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () => _handleSubmit(context),
                  child: const Text('Submit'),
                ),
              ] else
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (context
                                  .read<RiskRewardGraphCubit>()
                                  .state
                                  .dataPoints
                                  .length <
                              4) {
                            _toggleVisibility(context);
                          } else {
                            _showSnackBar(context);
                          }
                        },
                        child: const Text('Add'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _handleClearSubmit(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ])
            ],
          ),
        );
      },
    );
  }

  TableRow _buildTableRow(String label, Widget inputWidget) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: inputWidget,
          ),
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final formState = context.read<OptionFormCubit>().state;

      if (context.read<RiskRewardGraphCubit>().state.dataPoints.length < 4) {
        _updateGraphData(context, formState);
        _logFormState(formState);
      } else {
        _showSnackBar(context);
      }

      _toggleVisibility(context);
    }
  }

  void _handleClearSubmit(BuildContext context) {
    context.read<RiskRewardGraphCubit>().clearAllData();
  }

  void _updateGraphData(BuildContext context, OptionFormState formState) {
    context.read<RiskRewardGraphCubit>().addDataPoint(
          OptionData(
            strikePrice: formState.strikePrice,
            type: formState.type,
            bid: formState.bid,
            ask: formState.ask,
            longShort: formState.longShort,
            expirationDate: formState.expirationDate,
          ),
        );
  }

  void _logFormState(OptionFormState formState) {
    log(formState.toString(), name: "Log Printing the Values");
  }

  void _toggleVisibility(BuildContext context) {
    context.read<VisibilityCubit>().toggleVisibility();
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You can not add more than 4 inputs"),
      ),
    );
  }
}
