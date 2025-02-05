import 'package:flutter/material.dart';

import '../../../../utilities/app_routes/app_router.dart';
import '../../../screen/home/home_screen.dart';
import '../../../screen/sale/sale_screen.dart';
import '../../../screen/stock/stock_screen.dart';


class ListPageScaffold extends StatelessWidget {
  const ListPageScaffold({
    super.key,
    required this.label,
    required this.body,
    // required this.curentIndex,
    this.action,
    this.floatingActionButton,
  });

  final String label;
  final Widget? action;
  final Widget body;
  final Widget? floatingActionButton;
  // final int curentIndex;

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
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) {
      //     if (value == 0) {
      //     AppRouter.push(HomeScreen());
      //     } else if (value == 1) {
      // AppRouter.push(StockScreen());
      //     } else if (value == 2) {
      // AppRouter.push(SaleScreen());
      //     }
      //   },
      //   currentIndex: curentIndex,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home,
      //         ),
      //         label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.inventory,
      //         ),
      //         label: "Stock"),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.arrow_outward,
      //         ),
      //         label: "Sale"),
      //   ],
      // ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
