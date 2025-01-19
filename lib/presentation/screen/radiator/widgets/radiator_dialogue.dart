import 'package:flutter/material.dart';
import '../../../../domain/models/radiator.dart';
import '../../../../utilities/app_routes/app_routes.dart';
import '../../../widgets/car_selection_tile_dialogue/car_selection_tile_dialogue.dart';
import '../../../widgets/fin_selection_tile_dialogue/fin_selection_tile_dialogue.dart';
import '../../../widgets/input_feilds/number_input_field.dart';
import '../../../widgets/input_feilds/text_input_field.dart';
import '../../../widgets/row_selection_tile_dialogue/row_selection_tile_dialogue.dart';
import '../../../widgets/spaces/space.dart';

class RadiatorDialogue extends StatefulWidget {
  const RadiatorDialogue({super.key, this.radiator});
  final Radiator? radiator;

  @override
  State<RadiatorDialogue> createState() => _RadiatorDialogueState();
}

class _RadiatorDialogueState extends State<RadiatorDialogue> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CarFuelType _selectedFuelType = CarFuelType.petrol;
  CarAutomation _selectedCarAutomationType = CarAutomation.automatic;

  final TextEditingController sizeController = TextEditingController();
  final TextEditingController fromYearController = TextEditingController();
  final TextEditingController toYearController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
    fromYearController.dispose();
    toYearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => AppRouter.pop(),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // Save functionality here
              AppRouter.pop();
            }
          },
          child: Text(widget.radiator != null ? "Edit" : "Save"),
        ),
      ],
      title: Text(
        "Radiator Details",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CarSelectionTileDialogue(),
                smallestHeightSpace(),
                RowSelectionTileDialogue(),
                smallestHeightSpace(),
                FinSelectionTileDialogue(),
                smallestHeightSpace(),
                TextInputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter radiator size';
                    }
                    return null;
                  },
                  controller: sizeController,
                  label: "Enter Radiator Size",
                ),
                NumberInputField(
                  controller: fromYearController,
                  label: "Enter From Year",
                ),
                NumberInputField(
                  controller: toYearController,
                  label: "Enter To Year",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Fuel Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    smallWidthSpace(),
                    Expanded(
                      child: DropdownButton<CarFuelType>(
                        hint: Text('Select Fuel Type'),
                        value: _selectedFuelType,
                        isExpanded: true,
                        onChanged: (CarFuelType? newValue) {
                          setState(() {
                            _selectedFuelType = newValue!;
                          });
                        },
                        items: CarFuelType.values.map((CarFuelType fuelType) {
                          return DropdownMenuItem<CarFuelType>(
                            value: fuelType,
                            child: Text(
                              fuelType.toString().split('.').last,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Automation Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    smallWidthSpace(),
                    Expanded(
                      child: DropdownButton<CarAutomation>(
                        hint: Text('Select Car Automation Type'),
                        value: _selectedCarAutomationType,

                        isExpanded:
                            true, // This ensures the dropdown takes up the full width of its container
                        onChanged: (CarAutomation? newValue) {
                          setState(() {
                            _selectedCarAutomationType = newValue!;
                          });
                        },
                        items: CarAutomation.values
                            .map((CarAutomation carAutomationType) {
                          return DropdownMenuItem<CarAutomation>(
                            value: carAutomationType,
                            child: Text(
                              carAutomationType.toString().split('.').last,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
