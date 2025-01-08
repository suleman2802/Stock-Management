import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utilities/app_routes/app_routes.dart';
import '../../widgets/input_feilds/number_input_field.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/styling/bordered_container.dart';

class StockFormScreen extends StatefulWidget {
  const StockFormScreen({super.key});

  @override
  State<StockFormScreen> createState() => _StockFormScreenState();
}

class _StockFormScreenState extends State<StockFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//? variables
  String date = DateFormat('dd MM yyyy').format(DateTime.now());
  String time = DateFormat('hh:mm').format(DateTime.now());

//? controllers
  final TextEditingController profitInWholesalePriceController =
      TextEditingController();
  final TextEditingController profitInRetailPriceController =
      TextEditingController();
  final TextEditingController retailPriceController = TextEditingController();
  final TextEditingController reatilProfitMarginController =
      TextEditingController();
  final TextEditingController wholesaleRateController = TextEditingController();
  final TextEditingController wholesaleProfitMarginController =
      TextEditingController();
  final TextEditingController unitCostController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    profitInWholesalePriceController.dispose();
    profitInRetailPriceController.dispose();
    retailPriceController.dispose();
    reatilProfitMarginController.dispose();
    wholesaleRateController.dispose();
    wholesaleProfitMarginController.dispose();
    unitCostController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 1,
      label: "Add Stock",
      action: IconButton(
        icon: Icon(Icons.save, color: Theme.of(context).primaryColor),
        onPressed: () {
          //? validate form

          //? navigate to car screen
          navigateToStockScreen(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BorderedContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(8.0), child: Row(
                    children: [
                      Text("Stock Buy Date"),
                      Text("Time: $time"),
                    ],
                  )),
                  NumberInputField(
                    controller: quantityController,
                    label: "Quantity",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter quantity";
                      } else if (int.parse(value) < 0) {
                        return "Stock quantity can not be negative";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: unitCostController,
                    label: "Unit Cost",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter unit cost";
                      } else if (double.parse(value) < 0) {
                        return "Unit cost can not be negative";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: profitInWholesalePriceController,
                    label: "Profit in Wholesale Price",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter profit in wholesale price";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: profitInRetailPriceController,
                    label: "Profit in Retail Price",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter profit in retail price";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: retailPriceController,
                    label: "Retail Price",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter retail price";
                      } else if (double.parse(value) < 0) {
                        return "Retail price can not be negative";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: reatilProfitMarginController,
                    label: "Retail Profit Margin",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter retail profit margin";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: wholesaleRateController,
                    label: "Wholesale Rate",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter wholesale rate";
                      } else if (double.parse(value) < 0) {
                        return "Wholesale rate can not be negative";
                      }
                      return null;
                    },
                  ),
                  NumberInputField(
                    controller: wholesaleProfitMarginController,
                    label: "Wholesale Profit Margin",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter wholesale profit margin";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
