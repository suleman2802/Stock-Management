import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stock_management_application/presentation/widgets/spaces/space.dart';
import '../../../domain/models/car.dart';
import '../../../domain/models/radiator_stock.dart';
import '../../../domain/models/stock.dart';
import '../../widgets/car_selection_tile_dialogue/car_selection_tile_dialogue.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/state_indicators/error_text/error_text.dart';
import '../../widgets/state_indicators/loading_indicator/loading_indicator.dart';
import '../../widgets/state_indicators/no_data_avaliable_text/no_data_avaliable_text.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/radiator_stock_list_cubit.dart';
import 'widgets/single_stock_block.dart';

class StockFormScreen extends StatefulWidget {
  StockFormScreen({super.key, this.stock});
  Stock? stock;

  @override
  State<StockFormScreen> createState() => _StockFormScreenState();
}

class _StockFormScreenState extends State<StockFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate = DateTime.now();
  String? _selectedTime;
  Car? selectedCar;

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

  void _timePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      } else {
        setState(() {
          _selectedTime = pickedTime.format(context).toString(); //pickedTime;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.stock != null) {
      _selectedDate = widget.stock!.date;
      _selectedTime = widget.stock!.time.toString();
      selectedCar = widget.stock!.car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 1,
      label: "Add Stock",
      action: RoundIconButton(
        iconData: Icons.save,
        onPress: () {
          //? validate form

          //? navigate to car screen
        },
      ),
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
                      _selectedTime == null ? 'Pick up Time' : _selectedTime!,
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
            Row(children: [
              Expanded(
                  child: CarSelectionTileDialogue(
                assignSelectedCarFunction: () {},
              )),
              smallWidthSpace(),
              IconButton.filledTonal(
                onPressed: () => context.read<RadiatorStockCubit>().addStock(
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
                    ),
                icon: Icon(Icons.add),
              ),
            ]),
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
                              onPressed: () => context
                                  .read<RadiatorStockCubit>()
                                  .removeStock(index),
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                            Text(")----------------------"),
                          ],
                        ),
                        SingleStockBlock(
                          key: ValueKey(stocks[index].id),
                          radiatorStock: stocks[index],
                          index: index,
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
