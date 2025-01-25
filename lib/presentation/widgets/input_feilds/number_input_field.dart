import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.onChange});
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        validator: validator,
        onChanged: onChange,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
