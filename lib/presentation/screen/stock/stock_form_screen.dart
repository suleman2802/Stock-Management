import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/car.dart';
import '../../../domain/models/radiator_stock.dart';
import '../../../domain/models/stock.dart';
import '../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../utilities/app_alerts/app_alerts.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/car_selection_tile_dialogue/car_selection_tile_dialogue.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/styling/round_icon_button.dart';
import '../car/cubit/car_cubit.dart';
import 'cubit/radiator_stock_list_cubit.dart';
import 'cubit/stock_cubit.dart';
import 'stock_screen.dart';
import 'widgets/single_stock_block.dart';

class StockFormScreen extends StatefulWidget {
  StockFormScreen({super.key, this.stock, required this.isAluminium});
  Stock? stock;
  bool isAluminium;
  @override
  State<StockFormScreen> createState() => _StockFormScreenState();
}

class _StockFormScreenState extends State<StockFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate = DateTime.now();
  DateTime? _selectedTime = DateTime.now();
  Car? selectedCar;
  bool isAluminium = true;
  List<GlobalKey<FormState>> singleBlockKeys = [];
  Future<void> _startDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2501),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String getFormattedDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  String getFormattedTime(DateTime time) {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(time);
  }

  void _timePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      } else {
        setState(() {
          _selectedTime = DateTime(
            _selectedDate?.year ?? DateTime.now().year,
            _selectedDate?.month ?? DateTime.now().month,
            _selectedDate?.day ?? DateTime.now().day,
            pickedTime.hour,
            pickedTime.minute,
            pickedTime.hourOfPeriod,
          ); //pickedTime;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.stock != null) {
      _selectedDate = widget.stock!.date;
      _selectedTime = widget.stock!.time;
      selectedCar = widget.stock!.car;
      context
          .read<RadiatorStockCubit>()
          .intilizeStockList(widget.stock!.radiatorStock);
      for (var i = 0; i < widget.stock!.radiatorStock.length; i++) {
        singleBlockKeys.add(GlobalKey<FormState>());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 1,
      label: "Add Stock",
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          if (selectedCar != null) {
            singleBlockKeys.add(GlobalKey<FormState>());
            context.read<RadiatorStockCubit>().addStock(
                  RadiatorStock(
                    quantity: 0,
                    profitInWholesalePrice: 0,
                    profitInRetailPrice: 0,
                    retailPrice: 0,
                    retailProfitMargin: 0,
                    wholesaleRate: 0,
                    wholesaleProfitMargin: 0,
                    unitCost: 0,
                    company: null,
                    radiator: null,
                  ),
                );
          } else {
            AppAlertUtil.showError(context, "Select car first");
          }
        },
      ),
      action: RoundIconButton(
          iconData: Icons.save,
          onPress: () async {
            bool isValidated =
                context.read<RadiatorStockCubit>().valiadatRadiatorStockList();
            if (isValidated) {
              for (GlobalKey<FormState> singleBlockkey in singleBlockKeys) {
                if (singleBlockkey.currentState?.validate() ?? false) {
                } else {
                  AppAlertUtil.showError(
                      context, "Provide all necessary details");
                  break;
                }
              }
              if (widget.stock == null) {
                //add
                bool isAddedSuccessfully =
                    await context.read<StockCubit>().addNewStock(
                          Stock(
                            time: _selectedTime!,
                            car: selectedCar!,
                            date: _selectedDate!,
                            radiatorStock: context
                                .read<RadiatorStockCubit>()
                                .getAllListRecord(),
                          ),
                        );
                if (context.mounted) {
                  generalAlert(
                    context: context,
                    isSuccessful: isAddedSuccessfully,
                    tile: "Stock",
                    type: AlertType.added,
                  );
                }
              } else {
                //edit
                bool isUpdatedSuccessfully =
                    await context.read<StockCubit>().updateStock(
                          Stock(
                            id: widget.stock!.id,
                            time: _selectedTime!,
                            car: selectedCar!,
                            date: _selectedDate!,
                            radiatorStock: context
                                .read<RadiatorStockCubit>()
                                .getAllListRecord(),
                          ),
                        );
                if (context.mounted) {
                  generalAlert(
                    context: context,
                    isSuccessful: isUpdatedSuccessfully,
                    tile: "Stock",
                    type: AlertType.updated,
                  );
                }
              }
              AppRouter.pop();
            } else {
              AppAlertUtil.showError(context, "Provide all necessary details");
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? 'Pick up Date'
                          : getFormattedDate(_selectedDate!),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _startDatePicker)
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _selectedTime == null
                          ? 'Pick up Time'
                          : getFormattedTime(_selectedTime!),
                      //!.format(context).toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.lock_clock,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _timePicker),
                  ],
                ),
              ],
            ),
            BlocProvider(
              create: (context) => CarCubit(
                carRepository: context.read<CarRepository>(),
              ),
              child: CarSelectionTileDialogue(
                isAluminium: widget.isAluminium,
                selectedCar: selectedCar,
                assignSelectedCarFunction: (Car carSelected) {
                  setState(() {
                    selectedCar = carSelected;
                  });
                },
              ),
            ),
            BlocBuilder<RadiatorStockCubit, List<RadiatorStock>>(
              builder: (context, stocks) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: stocks.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("----------------------("),
                            IconButton(
                              onPressed: () {
                                singleBlockKeys.removeAt(index);
                                context
                                    .read<RadiatorStockCubit>()
                                    .removeStock(index);
                              },
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                            Text(")----------------------"),
                          ],
                        ),
                        SingleStockBlock(
                          isAluminium: isAluminium,
                          formKey: singleBlockKeys[index],
                          key: ValueKey(stocks[index].id),
                          radiatorStock: stocks[index],
                          index: index,
                          selectedCar: selectedCar,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
