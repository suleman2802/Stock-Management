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
      curentIndex: 0,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
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
              onTap: () => navigateToStockScreen(context),
            ),
            DashboardTileGrid(
              title: "Purchase",
              icon: Icons.arrow_outward_rounded,
              onTap: () => navigateToPurchaseScreen(context),
            ),
            DashboardTileGrid(
              title: "Radiators",
              icon: Icons.apps_rounded,
              onTap: () => navigateToRadiatorScreen(context),
            ),
            DashboardTileGrid(
              title: "Car",
              icon: Icons.car_crash,
              onTap: () => navigateToCarScreen(context),
            ),
            DashboardTileGrid(
              title: "Fin",
              icon: Icons.line_weight_rounded,
              onTap: () => navigateToFinScreen(context),
            ),
            DashboardTileGrid(
              title: "Row",
              icon: Icons.view_column_rounded,
              onTap: () => navigateToRowScreen(context),
            ),
            DashboardTileGrid(
              title: "Reports",
              icon: Icons.query_stats_sharp,
              onTap: () => navigateToReportsScreen(context),
            ),
          ],
        ),
      ),
    );
  }
}
