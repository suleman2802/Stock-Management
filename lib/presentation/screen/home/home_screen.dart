import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/company/abstract_company_repository/abstract_company_repository.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../domain/repositories/sale/abstract_sale_repository/abstract_sale_repository.dart';
import '../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../car/car_screen.dart';
import '../car/cubit/car_cubit.dart';
import '../company/company_screen.dart';
import '../company/cubit/company_cubit.dart';
import '../fin/cubit/fin_cubit.dart';
import '../fin/fin_screen.dart';
import '../radiator/cubit/radiator_cubit.dart';
import '../radiator/radiator_screen.dart';
import '../rows/cubit/rows_cubit.dart';
import '../rows/rows_screen.dart';
import '../sale/cubit/sale_cubit.dart';
import '../sale/sale_screen.dart';
import '../stock/cubit/stock_cubit.dart';
import '../stock/stock_screen.dart';
import 'widgets/dashboard_tile_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      label: "Home",
      // curentIndex: 0,
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
                      value: context.read<CompanyRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<StockRepository>(),
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
                    create: (context) => StockCubit(
                      stockRepository: context.read<StockRepository>(),
                    ),
                    child: StockScreen(),
                  ),
                ),
              ),
            ),
            DashboardTileGrid(
              title: "Sale",
              icon: Icons.arrow_outward_rounded,
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
                      value: context.read<CompanyRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<StockRepository>(),
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
                    RepositoryProvider.value(
                      value: context.read<SaleRepository>(),
                    ),
                  ],
                  child: BlocProvider(
                    create: (context) => SaleCubit(
                      saleRepository: context.read<SaleRepository>(),
                    ),
                    child: SaleScreen(),
                  ),
                ),
              ),
            ),
            DashboardTileGrid(
              title: "Reports",
              icon: Icons.query_stats_sharp,
              onTap: () {},
            ),
            DashboardTileGrid(
              title: "Companies",
              icon: Icons.home_work_outlined,
              onTap: () => AppRouter.push(
                RepositoryProvider.value(
                  value: context.read<CompanyRepository>(),
                  child: BlocProvider(
                    create: (context) => CompanyCubit(
                      companyRepository: context.read<CompanyRepository>(),
                    ),
                    child: CompanyScreen(),
                  ),
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
