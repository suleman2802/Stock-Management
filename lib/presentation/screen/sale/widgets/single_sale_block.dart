import 'package:flutter/material.dart';
import 'package:stock_management_application/presentation/widgets/spaces/space.dart';

import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/radiator_selection_tile_dialogue/radiator_selection_tile_dialogue.dart';
import '../../../widgets/styling/bordered_container.dart';

class SingleSaleBlock extends StatefulWidget {
  const SingleSaleBlock({super.key});

  @override
  State<SingleSaleBlock> createState() => _SingleSaleBlockState();
}

class _SingleSaleBlockState extends State<SingleSaleBlock> {
//? controllers

  final TextEditingController unitCostController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    unitCostController.dispose();
    quantityController.dispose();
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
              RadiatorSelectionTileDialogue(assignSelectedRadiatorFunciton: (){},),
              smallHeightSpace(),
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
            ],
          ),
        ),
      ),
    );
  }
}
