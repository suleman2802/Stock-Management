import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/sale_cubit.dart';
import 'cubit/sale_item_list_cubit.dart';
import 'sale_form_screen.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 2,
      label: "Sale",
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
                value: context.read<StockRepository>(),
              ),
              // RepositoryProvider.value(
              //   value: context.read<FinRepository>(),
              // ),
              // RepositoryProvider.value(
              //   value: context.read<RowsRepository>(),
              // ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<SaleCubit>(),
                ),
                BlocProvider(
                  create: (context) => SaleItemListCubit(),
                ),
              ],
              child: SaleFormScreen(),
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
                onChanged: (value) {},
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          mediumHeightSpace(),
          Expanded(
            child: BlocBuilder<SaleCubit, SaleState>(
              builder: (context, state) {
                if (state is SaleLoadingState) {
                  return LoadingIndicator();
                } else if (state is SaleErrorState) {
                  return ErrorText(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is SaleLoadedState) {
                  return state.saleList.isEmpty
                      ? NoDataAvaliableText()
                      : ListView.builder(
                          itemCount: state.saleList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {},
                              // AppRouter.push(
                              // MultiRepositoryProvider(
                              //   providers: [
                              //     RepositoryProvider.value(
                              //       value: context.read<RadiatorRepository>(),
                              //     ),
                              //     RepositoryProvider.value(
                              //       value: context.read<CarRepository>(),
                              //     ),
                              //     RepositoryProvider.value(
                              //       value: context.read<CompanyRepository>(),
                              //     ),
                              //     RepositoryProvider.value(
                              //       value: context.read<FinRepository>(),
                              //     ),
                              //     RepositoryProvider.value(
                              //       value: context.read<RowsRepository>(),
                              //     ),
                              //   ],
                              //   child: MultiBlocProvider(
                              //     providers: [
                              //       BlocProvider.value(
                              //         value: context.read<StockCubit>(),
                              //       ),
                              //       BlocProvider(
                              //         create: (context) => RadiatorStockCubit(),
                              //       ),
                              //     ],
                              //     child: SaleFormScreen(
                              //       sale: state.saleList[index],
                              //     ),
                              //   ),
                              // ),
                              // ),
                              title: Text(
                                state.saleList[index].customerName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text(state.saleList[index].date.toString()),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  state.saleList[index].saleItems.length
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final bool isDeletedSuccessfully =
                                      await context
                                          .read<SaleCubit>()
                                          .deleteSale(state.saleList[index].id);

                                  generalAlert(
                                    context: context,
                                    isSuccessful: isDeletedSuccessfully,
                                    tile: "Sale",
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
