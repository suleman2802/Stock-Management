import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/sale_item.dart';
import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/radiator_selection_tile_dialogue/radiator_selection_tile_dialogue.dart';
import '../../../widgets/spaces/space.dart';
import '../../../widgets/styling/bordered_container.dart';
import '../cubit/sale_item_list_cubit.dart';

class SingleSaleBlock extends StatefulWidget {
  SingleSaleBlock({
    super.key,
    required this.saleItem,
    required this.formKey,
    required this.index,
  });
  SaleItem saleItem;
  int index;
  final GlobalKey<FormState> formKey;

  @override
  State<SingleSaleBlock> createState() => _SingleSaleBlockState();
}

class _SingleSaleBlockState extends State<SingleSaleBlock> {
//? controllers

  final TextEditingController unitCostController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController subTotalController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    unitCostController.dispose();
    quantityController.dispose();
    subTotalController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unitCostController.text = widget.saleItem.unitCost.toString();
    quantityController.text = widget.saleItem.quantity.toString();
    subTotalController.text = widget.saleItem.subTotal.toString();
  }

  void updateUnitCost() {
    double unitCost = double.parse(unitCostController.text.trim());
    double subTotal = double.parse(subTotalController.text.trim());

    subTotal = unitCost * double.parse(quantityController.text.trim());

    subTotalController.text = subTotal.toString();
    context.read<SaleItemListCubit>().updatesaleItem(
          widget.index,
          widget.saleItem.copyWith(unitCost: unitCost, subTotal: subTotal),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: BorderedContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RadiatorSelectionTileDialogue(
                assignSelectedRadiatorFunciton: () {},
              ),
              smallHeightSpace(),
              NumberInputField(
                controller: quantityController,
                label: "Quantity",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<SaleItemListCubit>().updatesaleItem(
                        widget.index,
                        widget.saleItem.copyWith(
                          quantity: int.tryParse(
                                value.trim(),
                              ) ??
                              0,
                        ));
                  }
                },
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
                onChange: (value) {
                  if (value.isNotEmpty) {
                    updateUnitCost();
                  }
                },
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
                controller: subTotalController,
                label: "Sub Total",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<SaleItemListCubit>().updatesaleItem(
                        widget.index,
                        widget.saleItem.copyWith(
                          subTotal: double.tryParse(
                                value.trim(),
                              ) ??
                              0,
                        ));
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter sub total amount";
                  } else if (double.parse(value) < 0) {
                    return "Sub Total can not be negative";
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
