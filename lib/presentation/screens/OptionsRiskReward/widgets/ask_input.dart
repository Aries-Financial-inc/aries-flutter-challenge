import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';

Widget askInput(BuildContext context) {
  return BlocBuilder<OptionFormCubit, OptionFormState>(
    builder: (context, state) {
      return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a bid price';
          }
          final num? bid = num.tryParse(value);
          if (bid == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
        decoration: const InputDecoration(labelText: 'Ask Price'),
        keyboardType: TextInputType.number,
        onChanged: (value) => context
            .read<OptionFormCubit>()
            .updateAsk(double.tryParse(value) ?? 0),
      );
    },
  );
}
