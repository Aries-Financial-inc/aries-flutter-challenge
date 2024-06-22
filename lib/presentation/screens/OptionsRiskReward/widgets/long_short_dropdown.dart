import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/business_logic/cubit/optionsForm/option_form_cubit_cubit.dart';
import 'package:flutter_challenge/constants/enums.dart';

Widget longShortDropdown(BuildContext context) {
  return BlocBuilder<OptionFormCubit, OptionFormState>(
    builder: (context, state) {
      return DropdownButtonFormField<LongShort>(
        validator: (value) {
          if (value == null) {
            return 'Please select Long or Short';
          }
          return null;
        },
        value: state.longShort,
        onChanged: (value) =>
            context.read<OptionFormCubit>().updateLongShort(value!),
        items: LongShort.values.map((LongShort longShort) {
          return DropdownMenuItem<LongShort>(
            value: longShort,
            child: Text(longShort.toString().split('.').last),
          );
        }).toList(),
      );
    },
  );
}
