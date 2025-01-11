import 'package:flutter/material.dart';
import 'package:stock_management_application/utilities/app_routes/app_routes.dart';

class ListPageScaffold extends StatelessWidget {
  const ListPageScaffold({
    super.key,
    required this.label,
    required this.body,
    required this.curentIndex,
    this.action,
    this.floatingActionButton,
  });

  final String label;
  final Widget? action;
  final Widget body;
  final Widget? floatingActionButton;
  final int curentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: action != null
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: action,
                  ),
                )
              ]
            : [],
        title: Text(
          label,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            navigateToHomeScreen(context);
          } else if (value == 1) {
            navigateToStockScreen(context);
          } else if (value == 2) {
            navigateToPurchaseScreen(context);
          }
        },
        currentIndex: curentIndex,
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
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
