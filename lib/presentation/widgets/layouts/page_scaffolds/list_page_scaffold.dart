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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: action,
            ),
          )
        ],
        title: Text(
          label,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, "/home");
          } else if (value == 1) {
            Navigator.pushNamed(context, "/stock");
          } else if (value == 2) {
            Navigator.pushNamed(context, "/purchase");
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.inventory,
              ),
              label: "Stock"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_outward,
              ),
              label: "Purchase"),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
