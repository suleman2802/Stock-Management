import 'package:flutter/material.dart';


import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/styling/bordered_container.dart';
class SingleStockBlock extends StatefulWidget {
  const SingleStockBlock({super.key});

  @override
  State<SingleStockBlock> createState() => _SingleStockBlockState();
}

class _SingleStockBlockState extends State<SingleStockBlock> {
  
 

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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BorderedContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
      );
  }
}