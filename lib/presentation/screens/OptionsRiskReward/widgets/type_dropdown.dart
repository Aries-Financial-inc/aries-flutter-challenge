import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';
import 'package:flutter_challenge/constants/enums.dart';

Widget typeDropdown(BuildContext context) {
  return BlocBuilder<OptionFormCubit, OptionFormState>(
    builder: (context, state) {
      return DropdownButtonFormField<OptionTypes>(
        validator: (value) {
          if (value == null) {
            return 'Please select a type';
          }
          return null;
        },
        value: state.type,
        onChanged: (value) =>
            context.read<OptionFormCubit>().updateType(value!),
        items: OptionTypes.values.map((OptionTypes type) {
          return DropdownMenuItem<OptionTypes>(
            value: type,
            child: Text(type.toString().split('.').last),
          );
        }).toList(),
      );
    },
  );
}
