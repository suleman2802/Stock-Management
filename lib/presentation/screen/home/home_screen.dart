import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management_application/presentation/screen/fin/cubit/fin_cubit.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../fin/fin_screen.dart';
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
              onTap: () {},
            ),
            DashboardTileGrid(
              title: "Sale",
              icon: Icons.arrow_outward_rounded,
              onTap: () {},
            ),
            DashboardTileGrid(
              title: "Radiators",
              icon: Icons.apps_rounded,
              onTap: () {},
            ),
            DashboardTileGrid(
              title: "Car",
              icon: Icons.car_crash,
              onTap: () {},
            ),
            DashboardTileGrid(
              title: "Fin",
              icon: Icons.line_weight_rounded,
              onTap: () => AppRouter.push(RepositoryProvider.value(
                  value: context.read<FinRepository>(),
                  child: BlocProvider(
                    create: (context) => FinCubit(
                      finRepository: context.read<FinRepository>(),
                    ),
                    child: FinScreen(),
                  ))),
            ),
            DashboardTileGrid(
              title: "Row",
              icon: Icons.view_column_rounded,
              onTap: () {},
            ),
            DashboardTileGrid(
              title: "Reports",
              icon: Icons.query_stats_sharp,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
