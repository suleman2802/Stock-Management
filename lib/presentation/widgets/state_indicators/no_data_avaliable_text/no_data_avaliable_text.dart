import 'package:flutter/material.dart';

class NoDataAvaliableText extends StatelessWidget {
  const NoDataAvaliableText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Data Avaliable",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
