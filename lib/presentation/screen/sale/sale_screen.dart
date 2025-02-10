import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stock_management_application/utilities/app_alerts/app_alerts.dart';

import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/select_type_drop_down/select_type_drop_down.dart';
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

  DateTime? startDate;
  DateTime? endDate;
  bool isAluminium = true;

  selectedType(bool isAluminiumSelected) {
    setState(() {
      isAluminium = isAluminiumSelected;
    });
    context.read<SaleCubit>().fetchAllSales(isAluminium);
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 2,
      label: "Sale",
      action: Row(
        children: [
          RoundIconButton(
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
                  child: SaleFormScreen(
                    isAluminium: isAluminium,
                  ),
                ),
              ),
            ),
          ),
          SelectTypeDropDown(
            isAluminium: isAluminium,
            selectedTypeFunction: selectedType,
          ),
        ],
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
                hintText: "Search by Customer name",
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    await context
                        .read<SaleCubit>()
                        .fetchAllSalesByCustomerName(value.trim(), isAluminium);
                  } else {
                    await context.read<SaleCubit>().fetchAllSales(isAluminium);
                  }
                },
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(startDate != null
                      ? DateFormat('yyyy-MM-dd').format(startDate!)
                      : 'Starting date'),
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () => _selectStartDate(context),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(endDate != null
                      ? DateFormat('yyyy-MM-dd').format(endDate!)
                      : 'Ending date'),
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () => _selectEndDate(context),
                  ),
                ],
              ),
              IconButton(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  onPressed: () async {
                    if (startDate == null) {
                      AppAlertUtil.showError(
                          context, "Please Select Starting Date");
                    } else if (endDate == null) {
                      AppAlertUtil.showError(
                          context, "Please Select Ending Date");
                    } else if (startDate!.isAfter(endDate!)) {
                      AppAlertUtil.showError(context,
                          "Starting date shouldn't be after then ending date");
                    } else if (endDate!.isBefore(startDate!)) {
                      AppAlertUtil.showError(context,
                          "Ending date shouldn't be before then starting date");
                    } else {
                      await context.read<SaleCubit>().getAllSalesByStartEndDate(
                          startDate!, endDate!, isAluminium);
                    }
                  },
                  icon: Icon(
                    Icons.filter_alt,
                  )),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      startDate = null;
                      endDate = null;
                    });
                    searchController.text = "";
                    await context.read<SaleCubit>().fetchAllSales(isAluminium);
                  },
                  icon: Icon(
                    Icons.restart_alt_rounded,
                  )),
            ],
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
                                      value: context.read<StockRepository>(),
                                    ),
                                  ],
                                  child: MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<SaleCubit>(),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            SaleItemListCubit(),
                                      ),
                                    ],
                                    child: SaleFormScreen(
                                      isAluminium: isAluminium,
                                      sale: state.saleList[index],
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                state.saleList[index].customerName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(state.saleList[index].date
                                      .toString()
                                      .substring(0, 11) +
                                  "-" +
                                  state.saleList[index].time
                                      .toString()
                                      .substring(11, 19)),
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
                                          .deleteSale(state.saleList[index].id,
                                              isAluminium);

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
