import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/car.dart';
import '../../../../domain/models/company.dart';
import '../../../../domain/models/radiator.dart';
import '../../../../domain/models/radiator_stock.dart';
import '../../../../domain/repositories/car/abstract_car_repository/abstract_car_repository.dart';
import '../../../../domain/repositories/company/abstract_company_repository/abstract_company_repository.dart';
import '../../../../domain/repositories/fin/abstract_fin_repository/abstract_fin_repository.dart';
import '../../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
import '../../../../domain/repositories/rows/abstract_rows_repository/abstract_rows_repository.dart';
import '../../../widgets/company_selection_tile_dialogue/company_selection_tile_dialogue.dart';
import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/radiator_selection_tile_dialogue/radiator_selection_tile_dialogue.dart';
import '../../../widgets/spaces/space.dart';
import '../../../widgets/styling/bordered_container.dart';
import '../../company/cubit/company_cubit.dart';
import '../../radiator/cubit/radiator_cubit.dart';
import '../cubit/radiator_stock_list_cubit.dart';

class SingleStockBlock extends StatefulWidget {
  SingleStockBlock({
    super.key,
    required this.radiatorStock,
    required this.index,
    this.selectedCar,
    required this.formKey,
    required this.isAluminium,
  });
  RadiatorStock radiatorStock;
  int index;
  Car? selectedCar;
  final GlobalKey<FormState> formKey;
  bool isAluminium;

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

  Company? selectedCompany;
  Radiator? selectedRadiator;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    profitInWholesalePriceController.text =
        widget.radiatorStock.profitInWholesalePrice.toString();
    profitInRetailPriceController.text =
        widget.radiatorStock.profitInRetailPrice.toString();
    retailPriceController.text = widget.radiatorStock.retailPrice.toString();
    reatilProfitMarginController.text =
        widget.radiatorStock.retailProfitMargin.toString();
    wholesaleRateController.text =
        widget.radiatorStock.wholesaleRate.toString();
    wholesaleProfitMarginController.text =
        widget.radiatorStock.wholesaleProfitMargin.toString();
    unitCostController.text = widget.radiatorStock.unitCost.toString();
    quantityController.text = widget.radiatorStock.quantity.toString();
    selectedCompany = widget.radiatorStock.company;
    selectedRadiator = widget.radiatorStock.radiator;
  }

//Retail
  void calculateProfitAndProfitMarginOnBaseOfRetailPrice() {
    double unitCost = double.parse(unitCostController.text.trim());
    double retailPrice = double.parse(retailPriceController.text.trim());
    double retailProfit =
        double.parse(profitInRetailPriceController.text.trim());
    double retailProfitMargin =
        double.parse(reatilProfitMarginController.text.trim());

    retailProfit = retailPrice - unitCost;
    retailProfitMargin = (retailProfit / unitCost) * 100;

    profitInRetailPriceController.text = retailProfit.toString();
    reatilProfitMarginController.text = retailProfitMargin.toString();

    context.read<RadiatorStockCubit>().updateStock(
        widget.index,
        widget.radiatorStock.copyWith(
            retailPrice: retailPrice,
            retailProfitMargin: retailProfitMargin,
            profitInRetailPrice: retailProfit));
  }

  void calculateProfitAndProfitMarginOnBaseOfRetailProfit() {
    double unitCost = double.parse(unitCostController.text.trim());
    double retailPrice = double.parse(retailPriceController.text.trim());
    double retailProfit =
        double.parse(profitInRetailPriceController.text.trim());
    double retailProfitMargin =
        double.parse(reatilProfitMarginController.text.trim());

    retailPrice = unitCost + retailProfit;
    retailProfitMargin = (retailProfit / unitCost) * 100;

    retailPriceController.text = retailPrice.toString();
    reatilProfitMarginController.text = retailProfitMargin.toString();

    context.read<RadiatorStockCubit>().updateStock(
        widget.index,
        widget.radiatorStock.copyWith(
          profitInRetailPrice: retailProfit,
          retailPrice: retailPrice,
          retailProfitMargin: retailProfitMargin,
        ));
  }

  void calculateProfitAndProfitMarginOnBaseOfUnitCost() {
    double unitCost = double.parse(unitCostController.text.trim());
    double retailPrice = double.parse(retailPriceController.text.trim());
    double retailProfit =
        double.parse(profitInRetailPriceController.text.trim());
    double retailProfitMargin =
        double.parse(reatilProfitMarginController.text.trim());

    retailProfit = retailPrice - unitCost;
    retailProfitMargin = (retailProfit / unitCost) * 100;

    profitInRetailPriceController.text = retailProfit.toString();
    reatilProfitMarginController.text = retailProfitMargin.toString();

    context.read<RadiatorStockCubit>().updateStock(
          widget.index,
          widget.radiatorStock.copyWith(
            unitCost: unitCost,
            profitInRetailPrice: retailProfit,
            retailProfitMargin: retailProfitMargin,
          ),
        );
  }

  void calculateProfitAndProfitMarginOnBaseOfRetailProfitMargin() {
    double unitCost = double.parse(unitCostController.text.trim());
    double retailPrice = double.parse(retailPriceController.text.trim());
    double retailProfit =
        double.parse(profitInRetailPriceController.text.trim());
    double retailProfitMargin =
        double.parse(reatilProfitMarginController.text.trim());

    retailPrice = unitCost * (1 + (retailProfitMargin / 100));
    retailProfit = retailPrice - unitCost;

    retailPriceController.text = retailPrice.toString();
    profitInRetailPriceController.text = retailProfit.toString();

    context.read<RadiatorStockCubit>().updateStock(
        widget.index,
        widget.radiatorStock.copyWith(
          retailProfitMargin: retailProfitMargin,
          retailPrice: retailPrice,
          profitInRetailPrice: retailProfit,
        ));
  }

//Wholesale

  void calculateProfitAndProfitMarginOnBaseOfWholesalePrice() {
    double unitCost = double.parse(unitCostController.text.trim());
    double wholesalePrice = double.parse(wholesaleRateController.text.trim());
    double wholesaleProfit =
        double.parse(profitInWholesalePriceController.text.trim());
    double wholesaleProfitMargin =
        double.parse(wholesaleProfitMarginController.text.trim());

    wholesaleProfit = wholesalePrice - unitCost;
    wholesaleProfitMargin = (wholesaleProfit / unitCost) * 100;

    profitInWholesalePriceController.text = wholesaleProfit.toString();
    wholesaleProfitMarginController.text = wholesaleProfitMargin.toString();
    context.read<RadiatorStockCubit>().updateStock(
        widget.index,
        widget.radiatorStock.copyWith(
          wholesaleRate: wholesalePrice,
          wholesaleProfitMargin: wholesaleProfitMargin,
          profitInWholesalePrice: wholesaleProfit,
        ));
  }

  void calculateProfitAndProfitMarginOnBaseOfWholesaleProfit() {
    double unitCost = double.parse(unitCostController.text.trim());
    double wholesalePrice = double.parse(wholesaleRateController.text.trim());
    double wholesaleProfit =
        double.parse(profitInWholesalePriceController.text.trim());
    double wholesaleProfitMargin =
        double.parse(wholesaleProfitMarginController.text.trim());

    wholesalePrice = unitCost + wholesaleProfit;
    wholesaleProfitMargin = (wholesaleProfit / unitCost) * 100;

    wholesaleRateController.text = wholesalePrice.toString();
    wholesaleProfitMarginController.text = wholesaleProfitMargin.toString();

    context.read<RadiatorStockCubit>().updateStock(
        widget.index,
        widget.radiatorStock.copyWith(
          profitInWholesalePrice: wholesalePrice,
          wholesaleRate: wholesalePrice,
          wholesaleProfitMargin: wholesaleProfitMargin,
        ));
  }

  void calculateProfitAndProfitMarginOnBaseOfUnitCostInWholesale() {
    double unitCost = double.parse(unitCostController.text.trim());
    double wholesalePrice = double.parse(wholesaleRateController.text.trim());
    double wholesaleProfit =
        double.parse(profitInWholesalePriceController.text.trim());
    double wholesaleProfitMargin =
        double.parse(wholesaleProfitMarginController.text.trim());

    wholesaleProfit = wholesalePrice - unitCost;
    wholesaleProfitMargin = (wholesaleProfit / unitCost) * 100;

    profitInWholesalePriceController.text = wholesaleProfit.toString();
    wholesaleProfitMarginController.text = wholesaleProfitMargin.toString();

    context.read<RadiatorStockCubit>().updateStock(
          widget.index,
          widget.radiatorStock.copyWith(
            unitCost: unitCost,
            profitInWholesalePrice: wholesaleProfit,
            wholesaleProfitMargin: wholesaleProfitMargin,
          ),
        );
  }

  void calculateProfitAndProfitMarginOnBaseOfWholesaleProfitMargin() {
    double unitCost = double.parse(unitCostController.text.trim());
    double wholesalePrice = double.parse(wholesaleRateController.text.trim());
    double wholesaleProfit =
        double.parse(profitInWholesalePriceController.text.trim());
    double wholesaleProfitMargin =
        double.parse(wholesaleProfitMarginController.text.trim());

    wholesalePrice = unitCost * (1 + (wholesaleProfitMargin / 100));
    wholesaleProfit = wholesalePrice - unitCost;

    wholesaleRateController.text = wholesalePrice.toString();
    profitInWholesalePriceController.text = wholesaleProfit.toString();

    context.read<RadiatorStockCubit>().updateStock(
        widget.index,
        widget.radiatorStock.copyWith(
          wholesaleProfitMargin: wholesaleProfitMargin,
          wholesaleRate: wholesalePrice,
          profitInWholesalePrice: wholesaleProfit,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: BorderedContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider.value(
                      value: context.read<RadiatorRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<CarRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<FinRepository>(),
                    ),
                    RepositoryProvider.value(
                      value: context.read<RowsRepository>(),
                    ),
                  ],
                  child: BlocProvider(
                    create: (context) => RadiatorCubit(
                      radiatorRepository: context.read<RadiatorRepository>(),
                    ),
                    child: RadiatorSelectionTileDialogue(
                      isAluminium: widget.isAluminium,
                      selectedRadiator: widget.radiatorStock.radiator,
                      selectedCar: widget.selectedCar,
                      assignSelectedRadiatorFunciton:
                          (Radiator selectedRadiator) {
                        context.read<RadiatorStockCubit>().updateStock(
                              widget.index,
                              widget.radiatorStock.copyWith(
                                radiator: selectedRadiator,
                              ),
                            );
                      },
                    ),
                  ),
                ),
                BlocProvider(
                  create: (context) => CompanyCubit(
                      companyRepository: context.read<CompanyRepository>()),
                  child: CompanySelectionTileDialogue(
                    isAluminium: widget.isAluminium,
                    selectedCompany: widget.radiatorStock.company,
                    assignSelectedCompanyFunciton: (Company selectedCompany) {
                      context.read<RadiatorStockCubit>().updateStock(
                            widget.index,
                            widget.radiatorStock.copyWith(
                              company: selectedCompany,
                            ),
                          );
                    },
                  ),
                ),
                smallHeightSpace(),
                NumberInputField(
                  controller: quantityController,
                  label: "Quantity",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      context.read<RadiatorStockCubit>().updateStock(
                          widget.index,
                          widget.radiatorStock.copyWith(
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
                      calculateProfitAndProfitMarginOnBaseOfUnitCost();
                      calculateProfitAndProfitMarginOnBaseOfUnitCostInWholesale();
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
                  controller: retailPriceController,
                  label: "Retail Price",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      calculateProfitAndProfitMarginOnBaseOfRetailPrice();
                    }
                  },
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
                  controller: wholesaleRateController,
                  label: "Wholesale Rate",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      calculateProfitAndProfitMarginOnBaseOfWholesalePrice();
                    }
                  },
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
                  controller: profitInRetailPriceController,
                  label: "Profit in Retail Price",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      calculateProfitAndProfitMarginOnBaseOfRetailProfit();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter profit in retail price";
                    }
                    return null;
                  },
                ),
                NumberInputField(
                  controller: profitInWholesalePriceController,
                  label: "Profit in Wholesale Price",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      calculateProfitAndProfitMarginOnBaseOfWholesaleProfit();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter profit in wholesale price";
                    }
                    return null;
                  },
                ),
                NumberInputField(
                  controller: reatilProfitMarginController,
                  label: "Retail Profit Margin",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      calculateProfitAndProfitMarginOnBaseOfRetailProfitMargin();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter retail profit margin";
                    }
                    return null;
                  },
                ),
                NumberInputField(
                  controller: wholesaleProfitMarginController,
                  label: "Wholesale Profit Margin",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      calculateProfitAndProfitMarginOnBaseOfWholesaleProfitMargin();
                    }
                  },
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
    );
  }
}
