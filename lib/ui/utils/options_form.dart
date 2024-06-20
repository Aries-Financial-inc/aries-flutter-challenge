import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/constraints/colors.dart';
import '../../blocs/options_strategy_bloc.dart';
import '../../events/options_strategy_event.dart';
import '../../models/option_contract.dart';
import 'ego_text_field.dart';

class OptionsForm extends StatefulWidget {
  const OptionsForm({super.key});

  @override
  _OptionsFormState createState() => _OptionsFormState();
}

class _OptionsFormState extends State<OptionsForm> {
  final _formKey = GlobalKey<FormState>();
  final _strikePriceController = TextEditingController();
  final _typeController = TextEditingController();
  final _bidController = TextEditingController();
  final _askController = TextEditingController();
  final _longShortController = TextEditingController();
  final _expirationDateController = TextEditingController();
  OptionType? type = OptionType.call;
  LongShort longShort = LongShort.long;
  @override
  void dispose() {
    _strikePriceController.dispose();
    _typeController.dispose();
    _bidController.dispose();
    _askController.dispose();
    _longShortController.dispose();
    _expirationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EgoTextForm(
            controller: _strikePriceController,
            label: 'Strike Price',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 22,
          ),
          ListTile(
            title: const Text(
              'Call',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio<OptionType>(
              activeColor: AppColors.egoPrimaryColor,
              toggleable: true,
              value: OptionType.call,
              groupValue: type,
              onChanged: (OptionType? value) {
                setState(() {
                  type = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Put',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio<OptionType>(
              activeColor: AppColors.egoPrimaryColor,
              toggleable: true,
              value: OptionType.put,
              groupValue: type,
              onChanged: (OptionType? value) {
                setState(() {
                  type = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          TextFormField(
            controller: _bidController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Bid',
              labelStyle: TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the bid price';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 22,
          ),
          TextFormField(
            controller: _askController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Ask',
              labelStyle: TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the ask price';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 22,
          ),
          ListTile(
            title: const Text(
              'Long',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio<LongShort>(
              activeColor: AppColors.egoPrimaryColor,
              toggleable: true,
              value: LongShort.long,
              groupValue: longShort,
              onChanged: (LongShort? value) {
                setState(() {
                  longShort = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Short',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio<LongShort>(
              activeColor: AppColors.egoPrimaryColor,
              toggleable: true,
              value: LongShort.short,
              groupValue: longShort,
              onChanged: (LongShort? value) {
                setState(() {
                  longShort = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          TextFormField(
            controller: _expirationDateController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Expiration Date (YYYY-MM-DD)',
              labelStyle: TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the expiration date';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 22,
          ),
          FloatingActionButton.extended(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            backgroundColor: AppColors.egoPrimaryColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newOption = OptionContractDTO(
                  strikePrice: double.parse(_strikePriceController.text),
                  type: type!,
                  bid: double.parse(_bidController.text),
                  ask: double.parse(_askController.text),
                  longShort: longShort,
                  expirationDate:
                      DateTime.parse(_expirationDateController.text),
                );
                context
                    .read<OptionsStrategyBloc>()
                    .add(UpdateOptionsContracts([newOption]));
              }
            },
            label: const Text(
              'Add Option',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}
