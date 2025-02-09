import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/company/abstract_company_repository/abstract_company_repository.dart';
import '../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/stock_cubit.dart';
import 'cubit/radiator_stock_list_cubit.dart';
import 'stock_form_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StockCubit>().fetchAllStocks();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 1,
      label: "Stock",
      action: RoundIconButton(
        iconData: Icons.add,
        onPress: () => AppRouter.push(
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(
                value: context.read<RadiatorRepository>(),
              ),
              RepositoryProvider.value(
                value: context.read<CarRepository>(),
              ),
              RepositoryProvider.value(
                value: context.read<CompanyRepository>(),
              ),
              RepositoryProvider.value(
                value: context.read<FinRepository>(),
              ),
              RepositoryProvider.value(
                value: context.read<RowsRepository>(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<StockCubit>(),
                ),
                BlocProvider(
                  create: (context) => RadiatorStockCubit(),
                ),
              ],
              child: StockFormScreen(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SearchBar(
                onTap: () {},
                controller: searchController,
                hintText: "Search by car name",
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    await context
                        .read<StockCubit>()
                        .fetchAllStocksByCarName(value.trim());
                  } else {
                    await context.read<StockCubit>().fetchAllStocks();
                  }
                },
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          mediumHeightSpace(),
          Expanded(
            child: BlocBuilder<StockCubit, StockState>(
              builder: (context, state) {
                if (state is StockLoadingState) {
                  return LoadingIndicator();
                } else if (state is StockErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is StockLoadedState) {
                  return state.stockList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.stockList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () => AppRouter.push(
                                MultiRepositoryProvider(
                                  providers: [
                                    RepositoryProvider.value(
                                      value: context.read<RadiatorRepository>(),
                                    ),
                                    RepositoryProvider.value(
                                      value: context.read<CarRepository>(),
                                    ),
                                    RepositoryProvider.value(
                                      value: context.read<CompanyRepository>(),
                                    ),
                                    RepositoryProvider.value(
                                      value: context.read<FinRepository>(),
                                    ),
                                    RepositoryProvider.value(
                                      value: context.read<RowsRepository>(),
                                    ),
                                  ],
                                  child: MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<StockCubit>(),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            RadiatorStockCubit(),
                                      ),
                                    ],
                                    child: StockFormScreen(
                                      stock: state.stockList[index],
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                state.stockList[index].car.carName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text(state.stockList[index].car.carModel),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.stockList[index].radiatorStock.length
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final bool isDeletedSuccessfully =
                                      await context
                                          .read<StockCubit>()
                                          .deleteStock(
                                              state.stockList[index].id);

                                  generalAlert(
                                    context: context,
                                    isSuccessful: isDeletedSuccessfully,
                                    tile: "Stock",
                                    type: AlertType.deleted,
                                  );
                                },
                                icon: Icon(Icons.delete_forever,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        );
                } else {
                  return NoDataAvaliableText();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
