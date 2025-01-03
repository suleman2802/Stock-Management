import 'package:flutter/material.dart';

class ListPageScaffold extends StatelessWidget {
  const ListPageScaffold({
    super.key,
    required this.label,
    required this.body,
    this.action,
    this.floatingActionButton,
  });

  final String label;
  final Widget? action;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: action,
          )
        ],
        title: Text(
          label,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
