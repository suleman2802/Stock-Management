import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleInputPin extends StatelessWidget {
  const SingleInputPin({
    super.key,
    required this.pinController,
    required this.pinKey,
  });
  final TextEditingController pinController;
  final Key pinKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        height: 70,
        width: 60,
        child: TextFormField(
          key: pinKey,
          controller: pinController,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            FocusScope.of(context).nextFocus();
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 30,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
