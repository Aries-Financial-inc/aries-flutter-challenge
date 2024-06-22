import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';

Widget strikePriceInput(BuildContext context) {
  return BlocBuilder<OptionFormCubit, OptionFormState>(
    builder: (context, state) {
      return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a strike price';
          }
          final num? price = num.tryParse(value);
          if (price == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
        decoration: const InputDecoration(labelText: 'Strike Price'),
        keyboardType: TextInputType.number,
        onChanged: (value) => context
            .read<OptionFormCubit>()
            .updateStrikePrice(double.tryParse(value) ?? 0),
      );
    },
  );
}
