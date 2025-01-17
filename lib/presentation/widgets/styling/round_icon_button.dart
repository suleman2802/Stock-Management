import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
      {super.key, required this.onPress, required this.iconData});
  final void Function() onPress;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(
          iconData,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: onPress,
      ),
    );
  }
}
