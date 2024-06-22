import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';

Widget expirationDatePicker(BuildContext context) {
  return BlocBuilder<OptionFormCubit, OptionFormState>(
    builder: (context, state) {
      return GestureDetector(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: state.expirationDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != state.expirationDate) {
            context.read<OptionFormCubit>().updateExpirationDate(picked);
          }
        },
        child: InputDecorator(
          decoration: const InputDecoration(labelText: 'Expiration Date'),
          child: Text(
            state.expirationDate.toLocal().toString().split(' ')[0],
          ),
        ),
      );
    },
  );
}
