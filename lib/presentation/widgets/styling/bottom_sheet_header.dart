import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  final Widget? child;

  const BottomSheetHeader({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: child);
  }
}
