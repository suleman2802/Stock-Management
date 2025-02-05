import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../domain/models/sale.dart';
import '../../../domain/models/sale_item.dart';
import '../../../utilities/app_alerts/app_alerts.dart';
import '../../../utilities/app_routes/app_router.dart';
import '../../widgets/input_feilds/text_input_field.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/state_indicators/general_alert/general_alert.dart';
import '../../widgets/styling/round_icon_button.dart';
import 'cubit/sale_cubit.dart';
import 'cubit/sale_item_list_cubit.dart';
import 'widgets/single_sale_block.dart';

class SaleFormScreen extends StatefulWidget {
  SaleFormScreen({super.key, this.sale});
  Sale? sale;
  @override
  State<SaleFormScreen> createState() => _SaleFormScreenState();
}

class _SaleFormScreenState extends State<SaleFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController customerNameController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();
  DateTime? _selectedTime = DateTime.now();

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
    if (widget.sale != null) {
      _selectedDate = widget.sale!.date;
      _selectedTime = widget.sale!.time;

      context
          .read<SaleItemListCubit>()
          .intilizeSaleItemList(widget.sale!.saleItems);
      for (var i = 0; i < widget.sale!.saleItems.length; i++) {
        singleBlockKeys.add(GlobalKey<FormState>());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      // curentIndex: 2,
      label: "Add Sale",
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          singleBlockKeys.add(GlobalKey<FormState>());
          context.read<SaleItemListCubit>().addSaleItem(
                SaleItem(
                  subTotal: 0.0,
                  quantity: 1,
                  unitCost: 0.0,
                  saleType: SaleType.retail,
                ),
              );
        },
      ),
      action: RoundIconButton(
          iconData: Icons.save,
          onPress: () async {
            bool isValidated =
                context.read<SaleItemListCubit>().valiadatSaleItemList();
            if (isValidated) {
              for (GlobalKey<FormState> singleBlockkey in singleBlockKeys) {
                if (singleBlockkey.currentState?.validate() ?? false) {
                } else {
                  AppAlertUtil.showError(
                      context, "Provide all necessary details");
                  break;
                }
              }
              if (widget.sale == null) {
                //add
                bool isAddedSuccessfully =
                    await context.read<SaleCubit>().addNewsale(
                          Sale(
                            customerName: customerNameController.text.trim(),
                            totalBill: 0.0,
                            time: _selectedTime!,
                            date: _selectedDate!,
                            saleItems: context
                                .read<SaleItemListCubit>()
                                .getAllListRecord(),
                          ),
                        );
                if (context.mounted) {
                  generalAlert(
                    context: context,
                    isSuccessful: isAddedSuccessfully,
                    tile: "Sale",
                    type: AlertType.added,
                  );
                }
              } else {
                //edit
                bool isUpdatedSuccessfully =
                    await context.read<SaleCubit>().updatesale(
                          Sale(
                            totalBill: 0.0,
                            customerName: customerNameController.text.trim(),
                            id: widget.sale!.id,
                            time: _selectedTime!,
                            date: _selectedDate!,
                            saleItems: context
                                .read<SaleItemListCubit>()
                                .getAllListRecord(),
                          ),
                        );
                if (context.mounted) {
                  generalAlert(
                    context: context,
                    isSuccessful: isUpdatedSuccessfully,
                    tile: "Sale",
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
            TextInputField(
                label: "Customer Name", controller: customerNameController),
            mediumHeightSpace(),
            BlocBuilder<SaleItemListCubit, List<SaleItem>>(
              builder: (context, saleItems) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: saleItems.length,
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
                                    .read<SaleItemListCubit>()
                                    .removeSaleItem(index);
                              },
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                            Text(")----------------------"),
                          ],
                        ),
                        SingleSaleBlock(
                          formKey: singleBlockKeys[index],
                          key: ValueKey(saleItems[index].id),
                          saleItem: saleItems[index],
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
