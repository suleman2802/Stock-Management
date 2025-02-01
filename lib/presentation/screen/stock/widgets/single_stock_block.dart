import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/company.dart';
import '../../../../domain/models/radiator.dart';
import '../../../../domain/models/radiator_stock.dart';
import '../../../../domain/repositories/company/abstract_company_repository/abstract_company_repository.dart';
import '../../../../domain/repositories/radiator/abstract_radiator_repository/abstract_radiator_repository.dart';
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
  });
  RadiatorStock radiatorStock;
  int index;

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
                create: (context) => RadiatorCubit(
                    radiatorRepository: context.read<RadiatorRepository>()),
                child: RadiatorSelectionTileDialogue(
                  selectedRadiator: widget.radiatorStock.radiator,
                  assignSelectedRadiatorFunciton: (Radiator selectedRadiator) {
                    context.read<RadiatorStockCubit>().updateStock(
                          widget.index,
                          widget.radiatorStock.copyWith(
                            radiator: selectedRadiator,
                          ),
                        );
                  },
                ),
              ),
              BlocProvider(
                create: (context) => CompanyCubit(
                    companyRepository: context.read<CompanyRepository>()),
                child: CompanySelectionTileDialogue(
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
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          unitCost: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
                controller: profitInWholesalePriceController,
                label: "Profit in Wholesale Price",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          profitInWholesalePrice: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
                controller: profitInRetailPriceController,
                label: "Profit in Retail Price",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          profitInRetailPrice: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
                controller: retailPriceController,
                label: "Retail Price",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          retailPrice: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
                controller: reatilProfitMarginController,
                label: "Retail Profit Margin",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          retailProfitMargin: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
                controller: wholesaleRateController,
                label: "Wholesale Rate",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          wholesaleRate: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
                controller: wholesaleProfitMarginController,
                label: "Wholesale Profit Margin",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    context.read<RadiatorStockCubit>().updateStock(
                        widget.index,
                        widget.radiatorStock.copyWith(
                          wholesaleProfitMargin: double.tryParse(
                                value.trim(),
                              ) ??
                              0.9,
                        ));
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
    );
  }
}
