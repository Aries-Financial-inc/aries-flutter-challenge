import 'package:flutter/material.dart';

import 'option_contract_model.dart';

class OptionsInput extends StatefulWidget {
  final Function(OptionContract) onAddContract;

  const OptionsInput({super.key, required this.onAddContract});

  @override
  OptionsInputState createState() => OptionsInputState();
}

class OptionsInputState extends State<OptionsInput> {
  final TextEditingController _strikeController = TextEditingController();
  final TextEditingController _premiumController = TextEditingController();
  bool _isCall = true;
  bool _isLong = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _strikeController,
          decoration: const InputDecoration(labelText: 'Strike Price'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _premiumController,
          decoration: const InputDecoration(labelText: 'Premium'),
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            const Text('Call'),
            Switch(
              value: _isCall,
              onChanged: (value) {
                setState(() {
                  _isCall = value;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Long'),
            Switch(
              value: _isLong,
              onChanged: (value) {
                setState(() {
                  _isLong = value;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            final double strikePrice = double.parse(_strikeController.text);
            final double premium = double.parse(_premiumController.text);
            final option = OptionContract(
              strikePrice: strikePrice,
              premium: premium,
              isCall: _isCall,
              isLong: _isLong,
              expirationDate: DateTime.now(), // Placeholder for expiration date
            );
            widget.onAddContract(option);
          },
          child: const Text('Add Option'),
        ),
      ],
    );
  }
}
