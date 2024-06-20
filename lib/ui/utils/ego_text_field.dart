import 'package:flutter/material.dart';

class EgoTextForm extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  const EgoTextForm({
    super.key,
    required TextEditingController controller,
    required this.label,
    required this.keyboardType,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: _controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a strike price';
        }
        return null;
      },
    );
  }
}
