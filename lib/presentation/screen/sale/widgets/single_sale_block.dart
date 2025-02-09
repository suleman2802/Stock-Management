import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_management_application/utilities/app_alerts/app_alerts.dart';

import '../../../../domain/models/car.dart';
import '../../../../domain/models/radiator_stock.dart';
import '../../../../domain/models/sale_item.dart';
import '../../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../../domain/repositories/stock/abstract_stock_repository/abstract_stock_repository.dart';
import '../../../widgets/car_selection_tile_dialogue/car_selection_tile_dialogue.dart';
import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/radiator_stock_selection_tile_dialogue/radiator_stock_selection_tile_dialogue.dart';
import '../../../widgets/spaces/space.dart';
import '../../../widgets/styling/bordered_container.dart';
import '../../car/cubit/car_cubit.dart';
import '../../stock/cubit/stock_cubit.dart';
import '../cubit/sale_item_list_cubit.dart';

class SingleSaleBlock extends StatefulWidget {
  SingleSaleBlock(
      {super.key,
      required this.saleItem,
      required this.formKey,
      required this.index,
      this.selectedCar});
  SaleItem saleItem;
  int index;
  final GlobalKey<FormState> formKey;
  Car? selectedCar;

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

  void updateQuantity() {
    double unitCost = double.parse(unitCostController.text.trim());
    double subTotal = double.parse(subTotalController.text.trim());
    int quantity = int.parse(quantityController.text.trim());

    subTotal = unitCost * quantity;

    subTotalController.text = subTotal.toString();
    context.read<SaleItemListCubit>().updatesaleItem(
          widget.index,
          widget.saleItem.copyWith(quantity: quantity, subTotal: subTotal),
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
              BlocProvider(
                create: (context) => CarCubit(
                  carRepository: context.read<CarRepository>(),
                ),
                child: CarSelectionTileDialogue(
                  selectedCar: widget.selectedCar,
                  assignSelectedCarFunction: (Car carSelected) {
                    widget.selectedCar = carSelected;
                    context.read<SaleItemListCubit>().updatesaleItem(
                          widget.index,
                          widget.saleItem.copyWith(car: widget.selectedCar),
                        );
                  },
                ),
              ),
              BlocProvider(
                create: (context) => StockCubit(
                  stockRepository: context.read<StockRepository>(),
                ),
                child: RadiatorStockSelectionTileDialogue(
                  radiator: widget.saleItem.radiator,
                  car: widget.selectedCar,
                  assignSelectedRadiatorFunciton:
                      (RadiatorStock selectedRadiator) {
                    if (selectedRadiator.quantity < 1) {
                      AppAlertUtil.showError(context,
                          "You can have no stock left against this ${selectedRadiator.radiator!.size}");
                      setState(() {
                        widget.saleItem = widget.saleItem.copyWith(
                          radiator: null,
                        );
                      });
                    } else {
                      setState(() {
                        widget.saleItem = widget.saleItem.copyWith(
                          radiator: selectedRadiator,
                        );
                      });
                      context.read<SaleItemListCubit>().updatesaleItem(
                            widget.index,
                            widget.saleItem.copyWith(
                              radiator: selectedRadiator,
                            ),
                          );
                      unitCostController.text = widget.saleItem.isRetail
                          ? selectedRadiator.retailPrice.toString()
                          : selectedRadiator.wholesaleRate.toString();

                      updateUnitCost();
                    }
                  },
                ),
              ),
              smallHeightSpace(),
              Row(
                children: [
                  Expanded(
                    child: NumberInputField(
                      controller: quantityController,
                      label: "Quantity",
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          updateQuantity();
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
                  ),
                  largeWidthSpace(),
                  Row(
                    children: [
                      Text("Is Retail"),
                      Checkbox(
                        value: widget.saleItem.isRetail,
                        onChanged: (value) {
                          setState(() {
                            widget.saleItem = widget.saleItem.copyWith(
                              isRetail: value,
                            );
                          });

                          context.read<SaleItemListCubit>().updatesaleItem(
                                widget.index,
                                widget.saleItem.copyWith(isRetail: value),
                              );
                          unitCostController.text = value!
                              ? widget.saleItem.radiator!.retailPrice.toString()
                              : widget.saleItem.radiator!.wholesaleRate
                                  .toString();

                          updateUnitCost();
                        },
                      ),
                    ],
                  )
                ],
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
                            subTotal: double.tryParse(value) ??
                                int.parse(quantityController.text) *
                                    double.parse(
                                      unitCostController.text.trim(),
                                    ),
                          ),
                        );
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
