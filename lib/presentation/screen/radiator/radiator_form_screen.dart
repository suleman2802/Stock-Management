import 'package:flutter/material.dart';

import '../../../domain/models/radiator.dart';
import '../../widgets/input_feilds/number_input_field.dart';
import '../../widgets/input_feilds/text_input_field.dart';
import '../../widgets/layouts/page_scaffolds/list_page_scaffold.dart';
import '../../widgets/spaces/space.dart';
import '../../widgets/styling/bordered_container.dart';

class RadiatorFormScreen extends StatefulWidget {
  const RadiatorFormScreen({super.key});

  @override
  State<RadiatorFormScreen> createState() => _RadiatorFormScreenState();
}

class _RadiatorFormScreenState extends State<RadiatorFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CarFuelType _selectedFuelType = CarFuelType.petrol;
  CarAutomation _selectedCarAutomationType = CarAutomation.automatic;

  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carCompanyController = TextEditingController();
  final TextEditingController fromYearController = TextEditingController();
  final TextEditingController toYearController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    carNameController.dispose();
    carModelController.dispose();
    carCompanyController.dispose();
    fromYearController.dispose();
    toYearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageScaffold(
      curentIndex: 0,
      label: "Add Car",
      action: IconButton(
        icon: Icon(Icons.save, color: Theme.of(context).primaryColor),
        onPressed: () {
          //? validate form

          //? navigate to car screen
          
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BorderedContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Flexible(
                child: Column(
                  children: [
                    TextInputField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Car name';
                        } else if (value.length <= 2) {
                          return 'Car name must be more than 2 characters';
                        }
                        return null;
                      },
                      controller: carNameController,
                      label: "Enter Car Name",
                    ),
                    TextInputField(
                      controller: carModelController,
                      label: "Enter Car Model",
                    ),
                    TextInputField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Car company name';
                        } else if (value.length <= 2) {
                          return 'Compnay name must be more than 2 characters';
                        }
                        return null;
                      },
                      controller: carCompanyController,
                      label: "Enter Car Company",
                    ),
                    NumberInputField(
                      controller: fromYearController,
                      label: "Enter From Year",
                    ),
                    NumberInputField(
                      controller: toYearController,
                      label: "Enter To Year",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fuel Type",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: DropdownButton<CarFuelType>(
                              hint: Text('Select Fuel Type'),
                              value: _selectedFuelType,
                              onChanged: (CarFuelType? newValue) {
                                setState(() {
                                  _selectedFuelType = newValue!;
                                });
                              },
                              items: CarFuelType.values
                                  .map((CarFuelType fuelType) {
                                return DropdownMenuItem<CarFuelType>(
                                  value: fuelType,
                                  child: Text(
                                    fuelType.toString().split('.').last,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
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
        ),
      ),
    );
  }
}
