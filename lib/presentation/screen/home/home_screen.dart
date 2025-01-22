import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/row/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../car/car_screen.dart';
import '../car/cubit/car_cubit.dart';
import '../fin/cubit/fin_cubit.dart';
import '../fin/fin_screen.dart';
import '../radiator/cubit/radiator_cubit.dart';
import '../radiator/radiator_screen.dart';
import '../rows/cubit/rows_cubit.dart';
import '../rows/rows_screen.dart';
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
              onTap: () => AppRouter.push(
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => RadiatorCubit(
                        radiatorRepository: context.read<RadiatorRepository>(),
                      ),
                    ),
                    RepositoryProvider.value(
                      value: context.read<RadiatorRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<CarRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<FinRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<RowsRepository>(),
                    ),
                  ],
                  child: BlocProvider(
                    create: (context) => RadiatorCubit(
                      radiatorRepository: context.read<RadiatorRepository>(),
                    ),
                    child: RadiatorScreen(),
                  ),
                ),
              ),
            ),
            DashboardTileGrid(
              title: "Car",
              icon: Icons.car_crash,
              onTap: () => AppRouter.push(
                RepositoryProvider.value(
                  value: context.read<CarRepository>(),
                  child: BlocProvider(
                    create: (context) => CarCubit(
                      carRepository: context.read<CarRepository>(),
                    ),
                    child: CarScreen(),
                  ),
                ),
              ),
            ),
            DashboardTileGrid(
              title: "Fin",
              icon: Icons.line_weight_rounded,
              onTap: () => AppRouter.push(
                RepositoryProvider.value(
                  value: context.read<FinRepository>(),
                  child: BlocProvider(
                    create: (context) => FinCubit(
                      finRepository: context.read<FinRepository>(),
                    ),
                    child: FinScreen(),
                  ),
                ),
              ),
            ),
            DashboardTileGrid(
              title: "Row",
              icon: Icons.view_column_rounded,
              onTap: () => AppRouter.push(
                RepositoryProvider.value(
                  value: context.read<RowsRepository>(),
                  child: BlocProvider(
                    create: (context) => RowsCubit(
                      rowsRepository: context.read<RowsRepository>(),
                    ),
                    child: RowsScreen(),
                  ),
                ),
              ),
            ),
            DashboardTileGrid(
              title: "Reports",
              icon: Icons.query_stats_sharp,
              onTap: () async => log(await context
                  .read<RadiatorRepository>()
                  .getAllRadiators()
                  .toString()),
              // .addNewRadiator(
              //       Radiator(
              //         size: "37x5x60",
              //         carFuelType: CarFuelType.petrol,
              //         carAutomation: CarAutomation.manual,
              //         fromYear: 2023,
              //         toYear: 2024,
              //         rows: Rows(noOfRows: 5),
              //         car: Car(
              //             carCompany: "Honda",
              //             carModel: "MOD956",
              //             carName: "Civic"),
              //         fin: Fin(finSize: 9),
              //       ),
              //     ),
            ),
          ],
        ),
      ),
    );
  }
}
