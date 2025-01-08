import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField(
      {super.key,
      required this.label,
      required this.controller,
      this.validator});
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
