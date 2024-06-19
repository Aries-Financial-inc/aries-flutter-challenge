import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/options/options_bloc.dart';
import '../../../blocs/options/options_event.dart';
import '../../../blocs/options/options_state.dart';

class OptionsInput extends StatefulWidget {
  const OptionsInput({super.key});

  @override
  OptionsInputState createState() => OptionsInputState();
}

class OptionsInputState extends State<OptionsInput> {
  final _formKey = GlobalKey<FormState>();
  String _optionType = 'Call';
  double _strikePrice = 0.0;
  double _premium = 0.0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: _optionType,
              onChanged: (value) {
                setState(() {
                  _optionType = value!;
                });
              },
              items: ['Call', 'Put'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Option Type'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Strike Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a strike price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (double.parse(value) <= 0) {
                  return 'Strike price must be greater than zero';
                }
                return null;
              },
              onSaved: (value) {
                _strikePrice = double.parse(value!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Premium'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a premium';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (double.parse(value) < 0) {
                  return 'Premium cannot be negative';
                }
                return null;
              },
              onSaved: (value) {
                _premium = double.parse(value!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (int.parse(value) <= 0) {
                  return 'Quantity must be greater than zero';
                }
                return null;
              },
              onSaved: (value) {
                _quantity = int.parse(value!);
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus(); // dismiss keyboard
                _formKey.currentState!.save();
                context.read<OptionsBloc>().add(AddOptionContract(
                    _optionType, _strikePrice, _premium, _quantity));
                context.read<OptionsBloc>().add(const CalculateRiskReward());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Add Option Contract',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<OptionsBloc, OptionsState>(
            builder: (context, state) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.contracts.length,
                itemBuilder: (context, index) {
                  final contract = state.contracts[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                          '${contract.optionType} - Strike: ${contract.strikePrice}, Premium: ${contract.premium}, Quantity: ${contract.quantity}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          )),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          context
                              .read<OptionsBloc>()
                              .add(RemoveOptionContract(index));
                          context
                              .read<OptionsBloc>()
                              .add(const CalculateRiskReward());
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
