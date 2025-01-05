import 'package:flutter/material.dart';

import '../../../utilities/app_routes/app_routes.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import 'widgets/dashboard_tile_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Home",
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 8.0,
        ),
        children: [
          DashboardTileGrid(
            title: "Stock",
            icon: Icons.inventory,
            onTap: () {},
          ),
          DashboardTileGrid(
            title: "Purchase",
            icon: Icons.arrow_outward_rounded,
            onTap: () {},
          ),
          DashboardTileGrid(
            title: "Car",
            icon: Icons.car_crash,
            onTap: () => navigateToCarScreen(context),
          ),
          DashboardTileGrid(
            title: "Size",
            icon: Icons.miscellaneous_services_sharp,
            onTap: () {},
          ),
          DashboardTileGrid(
            title: "Reports",
            icon: Icons.query_stats_sharp,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
